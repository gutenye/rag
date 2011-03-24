require_relative "new/project"

class Rag  < Thor
	desc "new <project_name> or new .", "create a new project or use current directory"
	method_option "author", 		type: :string, banner: "NAME", desc: "the project's author name"
	method_option "email", 			type: :string, desc: "author's email address"
	method_option "template", 	type: :string, default: "default", banner: "NAME", desc: "which template to use"
	method_option "name", 			type: :string, banner: "NAME", desc: "rag new . [--name hello] default from File.basename(cur_path)"
	method_option "list", 			type: :boolean, desc: "list templates", aliaes: %w(-l)
	def new name
		if options.list?
			Project.list_templates
		end

		check_first_time

		Project.create name, options
	end

	private
	def check_first_time
 		return unless first_time?

		puts "first time run rag"
		(Rc.pa.data+'/home_config').each do |src|
			dest = '~/' + src.b.sub(/^_/, '.')
			puts "[create] #{dest.short}"
			Pa.cp src, dest
		end
		puts "exit."
		puts "please edit ~/.ragrc config file, then run rag again"
		exit
	end

	def first_time?
		Rc.pa.config.exists? ? false : true
	end

end
