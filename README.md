Rag, a project helper
=====================

**Homepage**: [https://github.com/GutenLinux/rag](https://github.com/GutenLinux/rag) <br/>
**Author**:	Guten <br/>
**License**: MIT-LICENSE <br/>
**Documentation**: [http://rubydoc.info/gems/rag/frames](http://rubydoc.info/gems/rag/frames) <br/>
**Issue Tracker**: [https://github.com/GutenLinux/rag/issues](https://github.com/GutenLinux/rag/issues) <br/>

Overview
--------

a project helper, include create, develop, test, release, add license

Usage
-----

	rag new # when first time run. create ~/.ragrc file, edit this file, than goto next step
	rag new foo # create a foo project in current directory

	rag -T # list tasks

	rag release # build gem and push to Ruygems


Install
----------

current still in developping, not relase a gem yet.

	gem install rag


Features
--------

* automatic add license header to source file when release (still in working)
* easy to extend.
* use thor as default task DSL.

Configuration
-------------

there are two places you can set up settings, ~/.ragrc, APP/.ragrc

.ragrc # a yaml file

	author: foo
	email: foo@bar.com

Extension
---------
 
you can write your own task in Ragfile, APP/tasks/\*.rag

	class Rag < Thor
		desc "hello", "it says hello"
		def hello
			puts 'hello'
		end
	end

or you can write a plugin.
	
lib/rag/foo.rb
	
	class Rag < Thor
		...
	end

in Ragfile

	require 'rag/foo'

avaliable variable for writing extension. they are read from .gemspec file

	Rc.o.project  # project name
	Rc.o.version


Template
--------

from system-level: GEM(rag)/template and user-level: ~/.rag/template

template/foo/a.erb

	<%=project%>

local variables in erb file are from ~/.ragrc and APP/.ragrc

default template see {file:template/default.readme}


TODO
-----

* add license task support


Resources
---------
* [hoe](https://github.com/seattlerb/hoe)


Copyright
---------
Copyright &copy; 2011 by Guten. this library released under MIT-LICENSE, See {file:LICENSE} for futher details.
