class Rag
	class License::Comment
		class Checker
			# @abstract
			class Base
				def initialize filetype
					raise NotImplementError, "abstract method"
				end

				# @abstract
				# @return [Boolean] is it a comment line?
				def check line
					raise NotImplementError, "abstract method"
				end

				# @abstract
				# detect use which checker.
				def detect line
					raise NotImplementError, "abstract method"
				end

				def self.inherited subclass
					Checker.checkers << subclass
				end
			end
		end
	end
end
