load File.expand_path('../../allah', __FILE__)
require 'test/unit'
require 'mocha/setup'

module AllahTestHelper
	def with_svdir(svdir)
		orig_svdir = ENV['ALLAH_SERVICE_DIR']
		ENV['ALLAH_SERVICE_DIR'] = svdir
		begin
			yield
		ensure
			ENV['ALLAH_SERVICE_DIR'] = orig_svdir
		end
	end
	
	def svdir(srv = "")
		File.join(File.expand_path('../service', __FILE__), srv)
	end
end
