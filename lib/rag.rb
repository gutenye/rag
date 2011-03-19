require "bundler/setup"
Bundler.require :default
require "thor"

class Rag < Thor
end

require_relative "rag/rc"
