require "tmpdir"

require "rag"
require "rag/new"
require "rag/doc"
require "rag/gem"
require "rag/test"
require "rag/license"

ENV["HOME"] = Dir.mktmpdir

class Rag
	Rc.pa.config = Pa(ENV['HOME']).join('.ragrc')
	Rc.pa.app_config = Pa(__FILE__).dirname.join('.ragrc')
end
