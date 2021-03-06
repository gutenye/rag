require "pd"
require "rag/init"
require "fakefs/spec_helpers"

$spec_dir = File.expand_path("..", __FILE__)
$spec_data = File.join($spec_dir, "data")
$spec_tmp = File.join($spec_dir, "tmp")

RSpec.configure do |config|
  def capture(stream=:stdout)
		require "stringio"
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end

  alias :silence :capture

  config.include FakeFS::SpecHelpers
end

module RSpec
  module Core
    module DSL
      def xdescribe(*args, &blk)
        describe *args do
          pending 
        end
      end

      alias xcontext xdescribe
    end
  end
end

def public_all_methods(*klasses)
	klasses.each {|klass|
		klass.class_eval {
      public *(self.protected_instance_methods(false) + self.private_instance_methods(false))
      public_class_method *(self.protected_methods(false) + self.private_methods(false))
    }
	}
end
