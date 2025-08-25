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

  test "should show user" do
    get user_path(@user)
    assert_response :success
    assert_select "h1", @user.username
    assert_select "p", @user.email
  end

  test "should update user with valid attributes" do
    patch user_path(@user), params: {
      user: {
        username: "updateduser",
        email: "updated@example.com",
        password: "newpassword123",
        password_confirmation: "newpassword123"
      }
    }
    assert_redirected_to user_path(@user)
    @user.reload
    assert_equal "updateduser", @user.username
    assert_equal "updated@example.com", @user.email
  end

  test "should not update user with invalid attributes" do
    patch user_path(@user), params: {
      user: {
        username: "",
        email: "invalid",
        password: "",
        password_confirmation: ""
      }
    }
    assert_response :unprocessable_entity
    @user.reload
    refute_equal "", @user.username
  end

  test "should delete user" do
    assert_difference("User.count", -1) do
      delete user_path(@user)
    end
    assert_redirected_to root_path
  end
end
