require "spec_helper"
require "fileutils"
require "tmpdir"

Project = Rag::Project

describe Project do
	before :all do
		@curdir = Dir.pwd
		@tmpdir = Dir.mktmpdir
		Dir.chdir(@tmpdir)
	end

	after :all do
		FileUtils.rm_r @tmpdir
		Dir.chdir(@curdir)
	end

	describe ".create" do
		it "runs ok" do
			Project.create "rb.app", "guten"
		end
	end
end

describe Rag do
	describe ".new" do
		it "first time create ragrc in $HOME" do
			#pd Rc.pa.config
			#Rag::Rc.pa.config.should be_exists
		end
	end
end
