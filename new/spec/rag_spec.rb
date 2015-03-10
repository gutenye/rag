require "spec_helper"

describe Rag do
  describe "#new" do
    it "works" do
      chdir $spec_tmp, :empty => true do
        Rag.new.invoke(:new, ["ruby.app.bar", "myapp"])

        File.read("myapp/hello").should == "hello"
        Rc.template.should == "ruby"
        Rc.exts.should == %w[app bar]
        Rc.ext.should == "app" # main ext
      end
    end
  end
end

