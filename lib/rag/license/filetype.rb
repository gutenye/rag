%w(
	from_filename
	from_filecontent
).each {|n| require_relative "filetype/#{n}" }

# detect a file type
class Rag
	class License::FileType
		@@detectors = [] # auto added by inherit FileType::Base
		def self.detect pa
			@@detectors.each do |detector|
				# return on the first successful find.
				if type=detector.detect(pa)
					return type
				end
			end	
		end
	end # class FileType
end
