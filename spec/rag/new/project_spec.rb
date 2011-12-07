require 'spec_helper'
require 'fileutils'
require 'tmpdir'

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

	describe '.create' do
		it 'runs ok' do
			Rag::Project.create 'default', 'guten', 'Guten', :author => 'Guten', :email => 'a@a.com'
		end
	end
end
