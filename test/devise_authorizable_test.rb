require 'test_helper'

class DeviseAuthorizableTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, DeviseAuthorizable
  end
end
