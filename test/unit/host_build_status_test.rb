require 'test_helper'

class HostBuildStatusTest < ActiveSupport::TestCase
  attr_reader :build

  setup do
    @build = HostBuildStatus.new(hosts(:one))
    # bypass host.valid?
    HostBuildStatus.any_instance.stubs(:host_status).returns(true)
  end

  test "should be able to render a template" do
    assert_empty build.errors[:templates]
  end

  test "should fail rendering a template" do
    host = hosts(:one)
    kind = FactoryGirl.create(:template_kind)
    config_template = FactoryGirl.create(:config_template, :template => "provision script <%= @foreman.server.status %>",:name => "My Failed Template", :template_kind => kind, :operatingsystem_ids => [host.operatingsystem_id], :environment_ids => [host.environment_id], :hostgroup_ids => [host.hostgroup_id]  )
    @build = HostBuildStatus.new(host)
    refute_empty @build.errors[:templates]
  end

  test "should be able to refresh a smart proxy" do
    assert_empty build.errors[:proxies]
  end
end
