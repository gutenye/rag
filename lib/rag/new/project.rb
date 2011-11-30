class Rag
=begin

== ERB support variables
* project 		# the name of your project, provided by `rag new <project_name>'
* others from .ragrc 

== Configrauton

+ ~/.ragrc 
+ APP/.ragrc 
+ from cmdline

you can use arbitrary name in .ragrc, then you can use then in template file.

=end
  class Project
    class << self
      def create(name, o={})
        Project.new(name, o).create
      end

      # find templates
      def templates
        templates = []
        templates << Rc.p.data.join("template").ls - %w(test)
        home_template_pa = Rc.p.home.join("template")
        templates << home_template_pa.ls if home_tempate_pa.exists?
      end

      # call by `rag new -l'
      def list_templates
        puts self.templates.join('\n')
      end
    end

    attr_reader :options, :name, :project
    def initialize(name, o={})
      @name = name
      @options = o
      @project = o["name"] ? o["name"] : (name=="." ? Rc.pwd.fname : name)
      @dest = Pa(@name)
    end

    def create
      create_project_directory
      if name=="."
        copy_files
      else
        copy_files :overwrite => true
      end
    end

  private
    def create_project_directory
      if @name=="."
        return
      elsif @dest.exists?
        puts "dest directory `#{@name}' already existing"
        exit
      else
        @dest.mkdir
      end
    end

    def template_path
      pa1 = Rc.p.home.join("template, options[:template]")
      return pa1.p if pa1.exists?

      pa2 = Rc.p.data.join("template", options[:template])
      return pa2.p if pa2.exists?

      raise Error, "can't find template -- #{options[:template]}"
    end

    def copy_files(o={})
      Pa.each_r template_path  do |pa, relative, e|
        # skip *~
        next if pa.b =~ /~$/

        # convert __project__ to @name
        dest = @dest.join(relative.gsub(/__project__/, project))
        path_msg = relative.gsub(/__project__/,project).gsub(/\.erb$/,'')

        # skip directory not file
        next if dest.exists? and dest.directory? 

        if not o[:overwrite] and (dest.exists? or dest.sub(/\.erb$/, '').exists?)
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
          puts "[create] #{path_msg}" + (dest.directory? ? '/' : '')
          copy_file pa, dest, o
        end

      end
    end

    # not rescurive copy
    def copy_file(src, dest, o)
      if src.e=='erb'
        copy_erb_file src, dest.sub(/\.erb$/,'')
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
      config = Optimism.require(%w[Rc.p.apprc, Rc.p.homerc]) + Optimism[options]
      config["project"] = project

      config._data
    end
  end
end
