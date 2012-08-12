# Rag, a project helper [![Build Status](https://secure.travis-ci.org/GutenYe/rag.png)](http://travis-ci.org/GutenYe/rag)

| Homepage:      |  https://github.com/GutenYe/rag       |
|----------------|---------------------------------------|
| Author:	       | Guten                                 |
| License:       | MIT-LICENSE                           |
| Documentation: | http://rubydoc.info/gems/rag/frames   |
| Issue Tracker: | https://github.com/GutenYe/rag/issues |

a project helper, include create, develop, test and release.

Features
--------

* easy to extend.
* use thor as default task DSL.
* with vim support. see resources 

Usage
-----

	rag new # when first time run. create ~/.ragrc file, edit this file, than goto next step
	rag new foo # create a foo project in current directory

	rag new -l # list templates

	rag -T # list tasks

	rag release # build gem and push to Ruygems

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

template path: ~/.rag/

~/.rag/foo/a.erb

	<%=project%>

local variables in erb file are from ~/.ragrc and APP/.ragrc

Install
----------

	gem install rag

Note on Patches/Pull Requests
-----------------------------

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.
6. Coding Style Guide: https://gist.github.com/1105334

Contributors
------------

* [contributors](https://github.com/GutenYe/rag/contributors)

Resources
---------

* [gem.vim](https://github.com/GutenYe/gem.vim): a project helper for ruby gem/library development
* [Hoe](https://github.com/seattlerb/hoe): a rake/rubygems helper for project

Requirements
------------

* ruby 1.9.3

Copyright
---------

(the MIT License)

Copyright (c) 2011 Guten

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
