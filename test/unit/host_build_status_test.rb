require 'test_helper'

class HostBuildStatusTest < ActiveSupport::TestCase
  attr_reader :build

  setup do
    @build = HostBuildStatus.new(hosts(:one))
  end

  test "should have be able to render a template" do
    assert_empty build.errors[:template]
  end

  test "should fail rendering a template" do
    @build = HostBuildStatus.new(hosts(:minimal))
    assert_empty build.errors[:template]

  end
end
