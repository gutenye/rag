require "spec_helper"

describe Rag do
  describe "#new" do
    it "works" do
      chdir $spec_tmp, :empty => true do
        Rag.new.invoke(:new, ["ruby.app", "hello"])
        File.read("hello/hello").should == "hello"
      end
    end
  end
end

