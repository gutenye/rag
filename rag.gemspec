$: << File.expand_path("../lib", __FILE__)
require "rag/version"

Gem::Specification.new do |s|
	s.name = "rag"
	s.version = Rag::VERSION
	s.summary = "A project helper, include create, developing, testing, release"
	s.description = <<-EOF
A project helper, include create, develop, test, release helper.  
	EOF

	s.author = "Guten"
	s.email = "ywzhaifei@gmail.com"
	s.homepage = "http://github.com/GutenYe/rag"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")
	s.executables = %w(rag)

	s.add_dependency "pa"
	s.add_dependency "thor"
end
