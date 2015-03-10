version = File.read(File.expand_path("../../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
	s.name = "rag-new"
	s.version = version
	s.summary = "generate project from templates"
	s.description = <<-EOF
generate project from templates
	EOF

	s.author = "Guten"
	s.email = "ywzhaifei@gmail.com"
	s.homepage = "http://github.com/GutenYe/rag"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")

  s.add_dependency "rag-core", version
  s.add_dependency "tagen", "~>2.0.0"
	s.add_dependency "pa", "~>1.3.0"
  s.add_dependency "optimism", "~>3.3.0"
	s.add_dependency "tilt"
end
