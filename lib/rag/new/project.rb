require "tagen/yaml"
require "tagen/erb"

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
	module ClassMethods
		def create name, o={}
			Project.new(name, o).create
		end

		# find templates
		def templates
			templates = []
			templates << Rc.pa.template.ls - %w(test)
			home_template_pa = Pa('~/.rag/template' )
			templates << home_template_pa.ls if home_tempate_pa.exists?
		end

		# call by `rag new -l'
		def list_templates
			puts self.templates.join('\n')
		end

	end
	extend ClassMethods

	attr_reader :options, :name, :project
	def initialize name, o={}
		@name = name
		@options = o
		@project = o["name"] ? o["name"] : (name=="." ? Pa.pwd2.base : name)
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
		path1 = File.join(ENV["HOME"], ".rag/template", options[:template])
		return path1 if File.exists?(path1)

		path2 = Rc.pa.template.join(options[:template]).p
		return path2 if File.exists?(path2)

		raise Error, "can't find template -- #{options[:template]}"
	end

	def copy_files o={}
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
	def copy_file src, dest, o
		if src.e=='erb'
			copy_erb_file src, dest.sub(/\.erb$/,'')
		else
			Pa.cp src, dest, o.merge(special: true)
		end
	end

	def copy_erb_file src, dest
		content = ERB.new(File.read(src.p)).result(nil, get_erb_config)
		File.write dest.p, content
		dest.chmod(src.stat.mode)
	end

	def get_erb_config
		# ~/.ragrc
		home_config = YAML.load(Rc.pa.config)
		# APP/.ragrc
		app_config = Rc.pa.app_config.exists? ? YAML.load(Rc.pa.app_config) : {}
		# cli
		cli_config = options

		config = home_config.merge(app_config).merge(cli_config)
		config["project"] = project

		o = OpenOption.new(config)
		o
	end


end
end
