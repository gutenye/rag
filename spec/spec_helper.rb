require "bundler/setup"
require "stringio"
require "fileutils"
require "pd"
require "rag"

$spec_dir = File.expand_path("..", __FILE__)
$spec_data = File.expand_path("../data", __FILE__)
$spec_tmp = File.expand_path("../tmp", __FILE__)

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
  def capture(stream)
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

module Kernel 
private

  def xdescribe(*args, &blk)
    describe *args do
      pending "xxxxxxxxx"
    end
  end

  def xcontext(*args, &blk)
    context *args do
      pending "xxxxxxxxx"
    end
  end

  def xit(*args, &blk)
    it *args do
      pending "xxxxxxxx"
    end
  end
end

# vim: ft=ruby
