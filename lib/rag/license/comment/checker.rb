class Rag
	class License::Comment
		class Checker
			cattr_accessor :checkers
			@@checkers = []

			def initialize filetype
				@filetype = filetype
			end

			def check line
				# first time, get a @checker
				if not @checker
					@checker = get_checker line

					# detect 
					checker = @@checkers.find {|checker|
						checker.detect line
					}

					if not checker
						return false
					end

				else

				end

			end
		end
	end
end
