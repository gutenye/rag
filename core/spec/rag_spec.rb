require "spec_helper"

describe Rag do
  describe ".ui" do
    it do
      expect(Rag.ui).to be_an_instance_of(Rag::UI)
    end
  end
end
