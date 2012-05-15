class Rag
  chainable = Module.new do
    def initialize(*)
      super

      # generate Rc.o
      o = Rc.o = Optimism.new
      if gemspec_file=Dir["*.gemspec"][0]
        gemspec = Gem::Specification.load(gemspec_file)
        o.project = gemspec.name
        o.version = gemspec.version
      end
    end
  end

  include chainable
end

require "rag/ruby/gem"
require "rag/ruby/test"
require "rag/ruby/doc"
