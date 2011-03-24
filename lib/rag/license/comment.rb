class Rag
	class License::Comment
		COMMENTS = {
			ruby: "#"
		}

		def self.get pa
			COMMENTS[FileType.detect(pa)]
		end
	end
end
