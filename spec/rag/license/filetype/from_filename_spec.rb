require "spec_helper"

From_Filename = Rag::License::Filetype::From_Filename

describe Rag::License::Filetype::From_Filename do
	describe "#detect" do
		it "runs ok" do
			pa = Pa('a.rb')
			From_Filename.new.detect(pa).should == :ruby 
		end
	end

end
