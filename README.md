Rag, a project helper
=====================

| Homepage:      |  https://github.com/GutenYe/rag       |
|----------------|---------------------------------------|
| Author:	       | Guten                                 |
| License:       | MIT-LICENSE                           |
| Documentation: | http://rubydoc.info/gems/rag/frames   |
| Issue Tracker: | https://github.com/GutenYe/rag/issues |

Overview
--------

a project helper, include create, develop, test and release.

Usage
-----

	rag new # when first time run. create ~/.ragrc file, edit this file, than goto next step
	rag new foo # create a foo project in current directory

	rag new -l # list templates

	rag -T # list tasks

	rag release # build gem and push to Ruygems


Features
--------

* easy to extend.
* use thor as default task DSL.
* with vim support. see resources 

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

available variable for writing extension. they are read from .gemspec file

	Rc.o.project  # project name
	Rc.o.version


Template
--------

from system-level: GEM(rag)/template and user-level: ~/.rag/template

template/foo/a.erb

	<%=project%>

local variables in erb file are from ~/.ragrc and APP/.ragrc

default template see {file:template/default.readme}

Install
----------

	gem install --no-wrappers rag
	gem update --no-wrappers rag

Contributing
-------------

* Feel free to join the project and make contributions (by submitting a pull request)
* Submit any bugs/features/ideas to github issue tracker
* Coding Style Guide: https://gist.github.com/1105334

Contributors
------------

* [contributors](https://github.com/GutenYe/rag/contributors)


Resources
---------

* [gem.vim](https://github.com/GutenYe/gem.vim): a project helper for ruby gem/library development
* [Hoe](https://github.com/seattlerb/hoe): a rake/rubygems helper for project


Copyright
---------

(the MIT License)

Copyright (c) 2011 <%=author%>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
