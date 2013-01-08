require File.expand_path('../test_helper', __FILE__)

class RestartTest < Test::Unit::TestCase
	include AllahTestHelper
	
	def test_basic_service_restart
		Kernel.expects(:system).with("svc -t dummysvc")
		allah = Allah.new(:arguments => ["restart", "dummysvc"], :svdir => svdir)
		allah.run
	end
	
	def test_group_restart
		Kernel.expects(:system).with("svc -t groupedsvc")
		allah = Allah.new(:arguments => ["restart", "groupedsvc"], :svdir => svdir)
		allah.run
	end
	
	def test_multigroup_restart
		Kernel.expects(:system).with("svc -t multigroup_a_b_c")
		Kernel.expects(:system).with("svc -t multigroup_a_b")
		allah = Allah.new(:arguments => ["restart", "a"], :svdir => svdir)
		allah.run
	end
end
