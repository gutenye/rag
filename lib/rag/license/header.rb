class Rag
	class License::Header
		def self.add context, header
			# insert position
			# skip magic line. #!
			pos = context[0,2] == "#!" ? context.index('\n') : 0

			# sort header
			header.rstrip!
			header << "\n\n"

			context.insert(start, header)
		end
	end
end
