require "active_support/core_ext/string/inflections"
require "pd"
require "pa"
require "optimism"
require "thor"

class Rag < Thor
  autoload :VERSION, "rag/version"
  autoload :UI, "rag/ui"
  autoload :Util, "rag/util"

  Error = Class.new Exception
  ENoTemplate = Class.new Error
  RagError = Class.new Exception
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

# new
class Rag
	desc "new <template_name> <app_path>", "create a new project"
  method_option "name", :aliases => "-n", :type => :string, :banner => "NAME", :desc => "new project name"
  method_option "klass", :aliases => "-k", :type => :string, :banner => "CLASS_NAME", :desc => "new class name"
  method_option "dir", :aliases => "-d", :type => :string, :banner => "DIR", :desc => "template directory"
	def new(template_name, app_path)
    o = options.dup
    template_name = template_name.dup
    app_path = Pa(app_path.dup)
    require "rag/new"
    
    template_name, *exts = template_name.split(".")
    template_dir = o[:dir] || Rc.p.home
    exts = exts.empty? ? ["default"] : exts
    root = Pa("#{template_dir}/#{template_name}").a
    raise ENoTemplate, "can't find '#{template_name}' at #{template_dir}" unless root.exists?

    app_path = Pa.absolute(app_path)
    o["name"] ||= app_path.fname 
    o["klass"] ||= o["name"].classify
    Rc << {
      template_name: template_name,
      app_path: app_path,
      project: o["name"],
      klass: o["klass"],
      exts: exts,
      ext: exts[0]
    }

    Pa.mkdir(app_path)
    Pa.cd(app_path)

    source = File.read("#{root}/Buildfile")
    DSL.source_root root.p
    dsl = DSL.new(template_name, app_path, o)
    dsl.destination_root = ""
    dsl.instance_eval source
	end
end
