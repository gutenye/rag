#require "tagen/core"
#require "pa"
#require "thor"
require "bundler/setup"
Bundler.require

class Rag < Thor
end

require_relative "rag/rc"
