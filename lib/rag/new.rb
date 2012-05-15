require "tilt"
require "rag/ext"

class Rag # Project Template DSL
=begin

== ERB support variables
* project 		# the name of your project, provided by `rag new <project_name>"
* others from .ragrc 

== Configrauton

+ ~/.ragrc 
+ APP/.ragrc 
+ from cmdline

you can use arbitrary name in .ragrc, then you can use then in template file.

=end
  class Project
    class << self
      def create(*args)
        Project.new(*args).create
      end
    end

    attr_reader :options, :template, :app_path
    def initialize(template, app_path, o={})
      @template = template
      @options = o
      o["name"] ||= Pa.absolute(app_path).fname 
      o["class_name"] ||= o["name"].capitalize
      @app_path = Pa(app_path)
    end

    def create
      create_project_directory
      if @app_path == "."
        copy_files
      else
        copy_files :overwrite => true
      end
    end

  private
    def create_project_directory
      if @app_path == "."
        return
      elsif app_path.exists?
        puts "dest directory `#{app_path}' already existing"
        exit
      else
        Pa.mkdir app_path
      end
    end

    def template_path
      p = Pa("#{Rc.p.home}/#{template}")
      return p.p if p.exists?

      raise Error, "can't find template -- #{template}"
    end

    def copy_files(o={})
      Pa.each_r template_path do |pa, abs, rel|
        # skip *~
        next if pa.fn2 =~ /~$/

        # convert __project__ to options["name"]
        dest = app_path.join(rel.gsub(/__project__/, options["name"]))
        path_msg = rel.gsub(/__project__/, options["name"]).gsub(/\.erb$/,"")

        # skip directory not file
        next if dest.exists? and dest.directory? 

        if not o[:overwrite] and (dest.exists? or dest.sub(/\.erb$/, "").exists?)
          print "Overwrite #{path_msg}? [yna] "
          case $stdin.gets.rstrip
          when "y"
            puts "[overwrite] #{path_msg}"
            copy_file pa, dest, o
          when "a"
            puts "[overwrite] #{path_msg}"
            o[:overwrite] = true
            copy_file pa, dest, o
          when "q"
            exit
          else
            puts "[skip] #{path_msg}"
            next
          end
        elsif o[:overwrite] and dest.exists?
          puts "[overwrite] #{path_msg}"
          copy_file pa, dest, o
        else
          # classify: file dir/
          puts "[create] #{path_msg}" + (dest.directory? ? "/" : "")
          copy_file pa, dest, o
        end

      end
    end

    # not rescurive copy
    def copy_file(src, dest, o)
      if src.e == "erb"
        copy_erb_file src, dest.sub(/\.erb$/,"")
      else
        Pa.cp src, dest, o.merge(special: true)
      end
    end

    def copy_erb_file(src, dest)
      result = Util::ERB.new(File.read(src.p)).result(binding, get_erb_config)
      File.write dest.p, result
      dest.chmod(src.stat.mode)
    end

    def get_erb_config
      config = Optimism.require(Rc.p.apprc.p, Rc.p.homerc.p) + Optimism[options]
      config["project"] = options["name"]
      config["klass"] = options["class_name"]
      config["template"] = @template

      config._data
    end
  end

  class Template
    Rc = Rag::Rc # used in hello.tt

    # @param [Hash] o options pass to initialize
    def self.render(source, o={}, &blk)
      scope = Template.new(o) 

      Tilt["erb"].new(source).render(scope, scope.locals, &blk)
    end

    attr_reader :source_root

    # @param [Hash] o options
    # @option o [String] :source_root ("")
    def initialize(o={})
      @source_root = o[:source_root] || ""
    end

    # path absolute or relative.
    def render(path)
      path = Pa(Pa.absolute?(path) ? path : Pa.join(source_root, path))
      path = path.build(fname: (path.base[0]=="_" ? "" : "_")+path.base)

      Tilt::ERBTemplate.new(path.p).render(self, locals)
    end

    def have_ext(ext)
      Rc.exts.include? ext
    end

    # for tilt
    def locals
      Rc._to_hash
    end
  end

  class DSL < Thor
    include Thor::Actions
    attr_reader :options, :template_name, :app_path

    def initialize(template_name, app_path, o={})
      @template_name = template_name
      @app_path = app_path
      @options = o
    end

    no_tasks do

      def project
        Rc.project
      end

    end

  private

    def have_ext(ext)
      Rc.exts.include? ext
    end
  end
end
