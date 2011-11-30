ENV["BUNDLE_GEMFILE"] = File.expand_path('../../Gemfile', __FILE__)
require "bundler/setup"
Bundler.require

class Rag < Thor
  autoload :VERSION, "rag/version"
  autoload :Util, "rag/util"
  autoload :Rc, "rag/config"
end

require "rag/new"
require "rag/gem"
require "rag/test"
require "rag/doc"

