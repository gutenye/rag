libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

ENV["BUNDLE_GEMFILE"] = File.expand_path("../../Gemfile", __FILE__)
require "bundler/setup"
Bundler.require

class Rag < Thor
  Error = Class.new Exception
  RagError = Class.new Exception

  autoload :VERSION, "rag/version"
  autoload :UI, "rag/ui"
  autoload :Util, "rag/util"

  Rc = Optimism.require "rag/rc", "~/.ragrc"

	include Thor::Actions

	class_option "no-color", :type => :boolean, :banner => "Disable colorization in output"
	class_option "verbose",  :type => :boolean, :banner => "Enable verbose output mode", :aliases => "-V"

  class << self
    attr_accessor :ui

		def ui
			@ui ||= UI::Base.new
		end
  end

	def initialize(*)
		super
		the_shell = (options["no-color"] ? Thor::Shell::Basic.new : shell)
		Rag.ui = UI::Shell.new(the_shell)
		Rag.ui.debug! if options["verbose"]
	end
end

require "rag/new"
require "rag/gem"
require "rag/test"
require "rag/doc"
