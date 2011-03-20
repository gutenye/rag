require_relative "new/project"

class Rag  < Thor
	desc "new <project_name> or new .", "create a new project or use current directory"
	method_option "author", 		type: :string, banner: "NAME", desc: "the project's author name"
	method_option "email", 			type: :string, desc: "author's email address"
	method_option "template", 	type: :string, default: "default", banner: "NAME", desc: "which template to use"
	method_option "name", 			type: :string, banner: "NAME", desc: "rag new . [--name hello] default from File.basename(cur_path)"
	def new name
		check_first_time

		Project.create name, options
	end

	private
	def check_first_time
 		return unless first_time?

		puts <<-EOF
first time run rag. 
  create ~/.ragrc config file with mode 600
  exit

please edit ~/.ragrc config file
		EOF
		Pa.cp Rc.pa.data+'/ragrc', Rc.pa.config
		exit
	end

	def first_time?
		Rc.pa.config.exists? ? false : true
	end

end
