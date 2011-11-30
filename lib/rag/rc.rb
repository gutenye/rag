p:
  root = Pa.dir(__FILE__).parent(2)
  home = Pa.join(ENV["HOME"], ".rag")
  homerc = Pa.join(ENV["HOME"], ".ragrc")
  apprc = Pa(".ragrc")
  data = root.join("data")
  
o:
  gemspec_file = Dir["*.gemspec"][0]
  if gemspec_file
    gemspec = Gem::Specification.load gemspec_file
    Rc.o.project = gemspec.name
    Rc.o.version = gemspec.version
  end



