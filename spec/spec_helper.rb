require "rag"

$spec_dir = File.expand_path("..", __FILE__)
$spec_data = File.expand_path("../data", __FILE__)

Rag::Rc._merge! Optimism <<EOF
p:
  root = nil
  home = Pa("#{$spec_data}/_rag")
  homerc = Pa("#{$spec_data}/_ragrc")
  apprc = Pa("#{$spec_data}/_apprc")
  data = nil
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
