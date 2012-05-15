module Ragen
	class Test < Thor
		default_task :default

		desc "default", "begin auto test", hide: true
		def default
			system "watchr #{Rag::Rc.o.project}.watchr", :verbose => true
		end

		desc "all", "test all"
		def all
			system "bundle exec rspec --color spec", :verbose => true
		end

	end
end

class Rag < Thor
	desc "test", "run test"
	subcommand "test", Ragen::Test
end
