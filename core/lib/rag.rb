require "pd"
require "thor"

class Rag < Thor
  autoload :UI, "rag/ui"

  Error = Class.new Exception
  ENoTemplate = Class.new Error
  RagError = Class.new Exception

  include Thor::Actions

  class_option "no-color", :type => :boolean, :banner => "Disable colorization in output"
  class_option "verbose",  :type => :boolean, :banner => "Enable verbose output mode", :aliases => "-V"

  class << self
    attr_accessor :ui

    def ui
      @ui ||= UI.new
    end
  end

  chainable = Module.new do
    def initialize(*)
      super
      the_shell = (options["no-color"] ? Thor::Shell::Basic.new : shell)
      Rag.ui = UI::Shell.new(the_shell)
      Rag.ui.debug! if options["verbose"]
    end
  end
  include chainable
end
