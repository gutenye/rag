class Rag # ::Project
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
      pa1 = Pa("#{Rc.p.home}/#{template}")
      return pa1.p if pa1.exists?

      raise Error, "can't find template -- #{template}"
    end

    def copy_files(o={})
      Pa.each_r template_path do |pa, relative, e|
        # skip *~
        next if pa.fn2 =~ /~$/

        # convert __project__ to options["name"]
        dest = app_path.join(relative.gsub(/__project__/, options["name"]))
        path_msg = relative.gsub(/__project__/, options["name"]).gsub(/\.erb$/,"")

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
end

class Rag < Thor
	desc "new <template> <app_path>", "create a new project"
  method_option "name", :aliases => "-n", :type => :string, :banner => "NAME", :desc => "another name"
  method_option "class_name", :aliases => "-c", :type => :string, :banner => "CLASS_NAME", :desc => "another class name"
	def new(template, app_path)
		check_first_time!

		Project.create template.dup, app_path.dup, options.dup
	end

private
	def check_first_time!
 		return unless first_time?

		puts "first time run rag"
    Pa.each("#{Rc.p.data}/home_config") { |src|
			dest = "~/" + src.b.sub(/^_/, ".")
			puts "[create] #{dest.short}"
			Pa.cp src, dest
    }

		puts "exit."
		puts "please edit ~/.ragrc config file, then run rag again"
		exit
	end

	def first_time?
		Rc.p.homerc.exists? ? false : true
	end
end
