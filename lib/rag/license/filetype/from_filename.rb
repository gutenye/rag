class Rag
	class License::FileType
		class FromFilename < Base
			EXTS = {
				"rb" => :ruby
			}

			def detect pa
				EXTS[pa.ext]
			end
		end
	end # class FileType
end
