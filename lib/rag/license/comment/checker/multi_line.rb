class Rag
		class License::Comment
			class Checker
				class MultiLine < Base
					COMMENTS={
						:ruby => [/^=begin/, /^=end/]
					}

					def initialize filetype
						@comment = COMMENTS[filetype.to_sym]

						# @is_end 
						#   0 is /^=end/ line
						#   1 is next line.  use this one
						@is_end = 0
					end

					def detect line
						line =~ @comment.first
					end

					def feed line
						@is_end += 1 if line =~ @coment.second 
						return @is_end == 1 ? false : true
					end
				end
			end
		end
end
