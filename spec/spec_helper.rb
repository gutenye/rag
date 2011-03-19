require "rag"
require "tmpdir"

ENV["HOME"] = Dir.mktmpdir

class Rag
	Rc.pa.config = Pa(ENV['HOME']).join('.ragrc')
	Rc.pa.app_config = Pa(__FILE__).dirname.join('.ragrc')
end
