module Ragen
	class Test < Thor
		default_task :default

		desc "default", "default", hide: true
		def default
			system "watchr #{Rag::Rc.o.project}.watchr", :verbose => true
		end

		desc "test [all]", "auto test with watchr"
		def all
			system "rspec --color spec", :verbose => true
		end

	end
end

class Rag < Thor
	desc "test", "run test"
	subcommand "test", Ragen::Test
end
