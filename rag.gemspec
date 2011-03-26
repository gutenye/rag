$: << "."
require "version"
require "bundler"

Gem::Specification.new do |s|
	s.name = "rag"
	s.version = Rag::VERSION::IS
	s.summary = "a project helper, include create, developing, testing, release"
	s.description = <<-EOF
a project helper, include create, develop, test, release
	EOF

	s.author = "Guten"
	s.email = "ywzhaifei@gmail.com"
	s.homepage = "http://github.com/GutenLinux/rag"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")
	s.executables = %w(rag)

	s.add_bundler_dependencies
end
