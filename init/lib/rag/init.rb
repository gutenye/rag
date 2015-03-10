require "pd"
require "rag"

class Rag
  class Init < Thor
    include Thor::Actions

    source_root File.join(Dir.home, ".rag/init")

    desc "run", "run"
    def run(name)
      template = find_in_source_paths("#{name}.rb")
      append_file "Ragfile", File.read(template)
    end
  end
end

class Rag
  desc "init <name>", "generate Ragfile" 
  def init(name)
    Init.new.invoke(:run, name)
  end
end

# load Ragfile, tasks/*.rag
Dir["Ragfile", "tasks/*.rag"].each { |file| Rag.class_eval(File.read(file)) }
