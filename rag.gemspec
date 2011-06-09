$: << "."
require "version"

Gem::Specification.new do |s|
	s.name = "rag"
	s.version = Rag::VERSION::IS
	s.summary = "a project helper, include create, developing, testing, release"
	s.description = <<-EOF
a project helper, include create, develop, test, release.  
INSTALL: gem install --no-wrappers rag.  
UPDATE: gem update --no-wrappers rag.
	EOF

	s.author = "Guten"
	s.email = "ywzhaifei@gmail.com"
	s.homepage = "http://github.com/GutenLinux/rag"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")
	s.executables = %w(rag)

	s.add_dependency 'tagen', '~>1.0.0'
	s.add_dependency 'pa', '~>1.0.0'
	s.add_dependency 'thor', '~>0.14.0'
end
