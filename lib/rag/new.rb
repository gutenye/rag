require_relative 'new/project'

class Rag  < Thor

	desc 'new <name> [class_name]', 'create a new project'
	method_option 'template', :aliases => '-t', :default => 'default', :type => :string, :banner => 'NAME', :desc => 'which template to use'
	def new(name, class_name=nil)
		check_first_time!

    class_name ||= name.capitalize
		Project.create name, class_name, options
	end

private
	def check_first_time!
 		return unless first_time?

		puts 'first time run rag'
		Rc.p.data.join('home_config').each do |src|
			dest = '~/' + src.b.sub(/^_/, '.')
			puts "[create] #{dest.short}"
			Pa.cp src, dest
		end
		puts 'exit.'
		puts 'please edit ~/.ragrc config file, then run rag again'
		exit
	end

	def first_time?
		Rc.p.homerc.exists? ? false : true
	end

end
