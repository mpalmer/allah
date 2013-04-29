require File.expand_path('../test_helper', __FILE__)

class RestartTest < Test::Unit::TestCase
	include AllahTestHelper
	
	def test_basic_service_restart
		Kernel.expects(:system).with("svc -t dummysvc")
		with_svdir(svdir) do
			allah = Allah::CLI.new(["restart", "dummysvc"])
			allah.run
		end
	end
	
	def test_group_restart
		Kernel.expects(:system).with("svc -t groupedsvc")
		with_svdir(svdir) do
			allah = Allah::CLI.new(["restart", "groupedsvc"])
			allah.run
		end
	end
end
