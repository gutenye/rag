libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

ENV["BUNDLE_GEMFILE"] = File.expand_path('../../Gemfile', __FILE__)
require "bundler/setup"
Bundler.require

class Rag < Thor
  autoload :VERSION, "rag/version"
  autoload :Util, "rag/util"

  Rc = Optimism.require %w[rag/rc ~/.ragrc]
end

require "rag/new"
require "rag/gem"
require "rag/test"
require "rag/doc"
