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

  test "should create user with valid attributes" do
    assert_difference("User.count") do
      post users_path, params: {
        user: {
          username: "newuser",
          email: "newuser@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end
    assert_redirected_to user_path(User.last)
  end

  test "should not create user with invalid attributes" do
    assert_no_difference("User.count") do
      post users_path, params: {
        user: {
          username: "",
          email: "invalid",
          password: "",
          password_confirmation: ""
        }
      }
    end
    assert_response :unprocessable_entity
  end
end
