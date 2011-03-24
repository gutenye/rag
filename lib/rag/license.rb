%w(
	filetype
	comment
	header
).each {|n| require_relative "license/#{n}" }

module Ragen
	class License < Thor
		#Rag::License
	end
end

class Rag < Thor

	desc "license", "license utils"
	subcommand "license", Ragen::License

end
