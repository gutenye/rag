class Rag < Thor

	desc "release", "release this gem to RubyGems.org"
	def release
		system "gem build #{Rc.o.project}.gemspec", :verbose
		system "gem push #{Rc.o.project}-#{Rc.o.version}.gem", :verbose
		Pa.rm "#{Rc.o.project}-#{Rc.o.version}.gem", verbose: true
	end

	desc "install", "install this gem to your system"
	def install
		sudo = Process.uid == 0 ? "" : "sudo"
		system "gem build #{Rc.o.project}.gemspec", :verbose
		system "#{sudo} gem install #{Rc.o.project}-#{Rc.o.version}.gem", :verbose
		Pa.rm "#{Rc.o.project}-#{Rc.o.version}.gem", verbose: true
	end

	desc "build", "build this gem at current directory "
	def build
		system "gem build #{Rc.o.project}.gemspec", :verbose
	end

end
