class Rag
	class License::Comment
		class Checker
			class OneLineChecker < Base
				COMMENTS={ 
					:ruby => /^\s*#/ 
				}

				def initialize filetype
					@comment = COMMENTS[filetype.to_sym]
				end

				def detect line
					line =~ @comment
				end

				def check line
					line =~ @comment
				end
			end # class OneLineChecker
		end
	end
end
