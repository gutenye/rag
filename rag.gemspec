Kernel.load File.expand_path("../lib/rag/version.rb", __FILE__)

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

  s.add_dependency "pd"
  s.add_dependency "tagen", "~>2.0.0"
	s.add_dependency "pa", "~>1.3.0"
  s.add_dependency "optimism", "~>3.2.0"
	s.add_dependency "thor"
	s.add_dependency "tilt"
end
