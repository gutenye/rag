require "bundler/setup"
Bundler.require :default
require "thor"
require "tagen/core"

class Rag < Thor
end

require_relative "rag/rc"
