version = File.read(File.expand_path("../../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
	s.name = "rag-core"
	s.version = version
	s.summary = "core part of rag"
	s.description = <<-EOF
core part of rag
	EOF

	s.author = "Guten"
	s.email = "ywzhaifei@gmail.com"
	s.homepage = "http://github.com/GutenYe/rag"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")
	s.executables = %w(rag)

  s.add_dependency "pd"
  s.add_dependency "thor"
end
