class Rag < Thor
	desc "doc", "test documentation with yard server --reload"
	def doc
		system "yard server --reload", :verbose => true
	end
end
