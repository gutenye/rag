desc "build a gem file"
task :release do
	sh "gem build rag.gemspec"
	sh "gem push *.gem"
	sh "rm *.gem"
end

desc "install a gem file"
task :install do
	sh "gem build rag.gemspec"
	sh "gem install *.gem"
	sh "rm *.gem"
end

desc "autotest with watchr"
task :test do
	sh "watchr rag.watchr"
end

desc "testing the libraray"
namespace :test do
	task :all do
		sh "rspec spec"
	end
end

desc "run yard server --reload"
task :doc do
	sh "yard server --reload"
end

def sh cmd
	puts cmd
	system cmd
end
