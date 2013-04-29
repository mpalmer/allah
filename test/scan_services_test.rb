require File.expand_path('../test_helper', __FILE__)

class CoreTest < Test::Unit::TestCase
	include AllahTestHelper
	
	def setup
		@svclist = Allah.scan_services(svdir)
	end
	
	def test_scan_services_returns_a_hash
		assert @svclist.is_a? Hash
	end
	
	def test_scan_services_returns_services
		@svclist[:services].values.each { |s| assert s.is_a?(Allah::Service), "#{s.inspect} is not an Allah::Service" }
		dummysvc = @svclist[:services]["dummysvc"]
		assert dummysvc, "Could not find dummysvc"
	end
	
	def test_scan_services_returns_groups
		@svclist[:groups].values.each { |g| assert g.is_a?(Allah::Group), "#{g.inspect} is not an Allah::Group" }
		dummygroup = @svclist[:groups]["dummygroup"]
		assert dummygroup, "Could not find group dummygroup in #{@svclist.inspect}"
		
		groupedsvc = dummygroup.services.find { |s| s.name == "groupedsvc" }
		assert groupedsvc, "Could not find groupedsvc in dummygroup (#{dummygroup.inspect})"
	end
end
