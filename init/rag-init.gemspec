version = File.read(File.expand_path("../../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
	s.name = "rag-init"
	s.version = version
	s.summary = "helper to generate Ragfile"
	s.description = <<-EOF
helper to generate Ragfile.  
	EOF

	s.author = "Guten"
	s.email = "ywzhaifei@gmail.com"
	s.homepage = "http://github.com/GutenYe/rag"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")

  s.add_dependency "rag-core", version
end
