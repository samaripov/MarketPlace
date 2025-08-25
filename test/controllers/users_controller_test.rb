require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_path
    assert_response :success
    assert_select "h1", "Users"
  end
end
