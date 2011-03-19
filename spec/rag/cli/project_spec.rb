require "spec_helper"
require "fileutils"
require "tmpdir"


describe Rag::Project do
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
		before :all do
			Rag::Project.create "guten", template: 'default', author: 'Test', email: 'test@test.com'
		end

		it "runs ok" do
		end

	end

end
