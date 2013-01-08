require File.expand_path('../test_helper', __FILE__)

class CoreTest < Test::Unit::TestCase
	include AllahTestHelper
	
	def setup
		@svclist = Allah.new(:svdir => svdir).scan_services
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
		assert dummygroup, "Could not find dummygroup"
		
		groupedsvc = dummygroup.services.find { |s| s.name == "groupedsvc" }
		assert groupedsvc, "Could not find groupedsvc in dummygroup (#{dummygroup.inspect})"
	end
	
	def test_scan_services_returns_multigroups
		assert @svclist[:groups].keys.include?("a"), "Groups list does not include group 'a'"
		assert @svclist[:groups].keys.include?("b"), "Groups list does not include group 'b'"
		assert @svclist[:groups].keys.include?("c"), "Groups list does not include group 'c'"
	end
	
	def test_scan_services_multigroups_includes_correct_services
		assert_equal %w{multigroup_a_b  multigroup_a_b_c},
		             @svclist[:groups]['a'].services.map { |s| s.name }.sort

		assert_equal %w{multigroup_a_b  multigroup_a_b_c  multigroup_b_c},
		             @svclist[:groups]['b'].services.map { |s| s.name }.sort

		assert_equal %w{multigroup_a_b_c multigroup_b_c},
		             @svclist[:groups]['c'].services.map { |s| s.name }.sort
	end
end
