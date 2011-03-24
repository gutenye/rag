class Rag
	class License::FileType
		cattr_accessor :detectors

		# @abstract
		class Base 
			def self.inherited klass
				FileType.detectors << klass
			end

			# @abstract
			# @return [Symbol] filetype
			def detect pa
				raise NotImplementError, "abstract method"
			end

		end
	end
end
