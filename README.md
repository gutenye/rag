# Rag, a modular project helper [![Build Status](https://secure.travis-ci.org/GutenYe/rag.png)](http://travis-ci.org/GutenYe/rag)

|                |                                       |
|----------------|---------------------------------------|
| Homepage:      | https://github.com/GutenYe/rag        |
| Author:	       | Guten                                 |
| License:       | GPL |
| Documentation: | http://rubydoc.info/gems/rag/frames   |
| Issue Tracker: | https://github.com/GutenYe/rag/issues |
| Ruby Versions: | Ruby 1.9.3, Rubinius                  |

a project helper, include create, develop, test and release.

Features
--------

* modularity: easy to create a plugin.
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

Extension & Plugin
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

Copyright
---------

Copyright 2011-2012 Guten Ye

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
