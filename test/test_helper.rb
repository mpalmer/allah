load File.expand_path('../../allah', __FILE__)
require 'test/unit'
require 'mocha/setup'

module AllahTestHelper
	def svdir(srv = "")
		File.join(File.expand_path('../service', __FILE__), srv)
	end
end
