require "spec_helper"
require "fileutils"
require "tmpdir"
require "rag/new"
require "rag/ext"

Project = Rag::Project

=begin
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
=end
