require "pd"
require "rag"
require "fileutils"

$spec_dir = File.expand_path("..", __FILE__)
$spec_data = File.join($spec_dir, "data")
$spec_tmp = File.join($spec_dir, "tmp")

Rc = Rag::Rc
Rc._merge! <<EOF
p:
  root = nil
  home = Pa("#{$spec_data}/home")
  homerc = Pa("#{$spec_data}/ragrc")
  apprc = Pa("#{$spec_data}/apprc")
  data = nil

author = "Test"
email = "test@test.com"
license = "TEST-LICENSE"

github:
  username = "TestYe"
EOF

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

  def chdir(dir, o={}, &blk)
    begin
      cwd = Dir.pwd
      Dir.chdir(dir)
    ensure
      Dir.chdir(cwd)
      if o[:empty]
        FileUtils.rm_r Dir.entries(dir).tap{|v| v.delete("."); v.delete(".."); v.delete(".gitkeep")}
      end
    end
  end
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
