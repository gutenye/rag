require "tmpdir"

require "rag"
require "rag/new"
require "rag/doc"
require "rag/gem"
require "rag/test"

ENV["HOME"] = Dir.mktmpdir
Pa.cp Rag::Rc.pa.home_config+'/_ragrc', Pa(ENV["HOME"]).join('.ragrc')

class Rag
	Rc.pa.config = Pa(ENV['HOME']).join('.ragrc')
	Rc.pa.app_config = Pa(__FILE__).dirname.join('.ragrc')
end
