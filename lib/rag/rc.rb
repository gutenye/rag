class Rag
  Rc = OpenOption.new
	Rc.pa = OpenOption.new
		Rc.pa.config = Pa(ENV['HOME']).join('.ragrc')
		Rc.pa.app = Pa(__FILE__).dir2.parent(2)
			Rc.pa.app_config = Rc.pa.app.join('.ragrc')
			Rc.pa.data = Rc.pa.app.join('datas')
			Rc.pa.template = Rc.pa.app.join('template')

	Rc.o = OpenOption.new
		gemspec_file = Dir['*.gemspec'][0]
		if gemspec_file
			gemspec = Gem::Specification.load gemspec_file
			Rc.o.project = gemspec.name
			Rc.o.version = gemspec.version
		end

end
