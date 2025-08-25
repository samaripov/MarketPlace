require "test_helper"

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def valid_user_attributes
    {
      username: "testuser",
      email: "unique_email@example.com",
      password: "password123",
      password_confirmation: "password123"
    }
  end

  test "should be valid with all required attributes" do
    user = User.new(valid_user_attributes)
    assert user.valid?
  end

  test "should be invalid without username" do
    attrs = valid_user_attributes.except(:username)
    user = User.new(attrs)
    assert_not user.valid?
    assert_includes user.errors[:username], "can't be blank"
  end

  test "should be invalid without email" do
    attrs = valid_user_attributes.except(:email)
    user = User.new(attrs)
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "should be invalid without password" do
    attrs = valid_user_attributes.except(:password)
    user = User.new(attrs)
    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  test "should be invalid with improperly formatted email" do
    attrs = valid_user_attributes.merge(email: "invalid_email")
    user = User.new(attrs)
    assert_not user.valid?
    assert_includes user.errors[:email], "is invalid"
  end

  test "should be invalid with non-unique email from fixture" do
    user = User.new(valid_user_attributes.merge(email: users(:one).email))
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "should be invalid if password confirmation does not match" do
    attrs = valid_user_attributes.merge(password_confirmation: "different")
    user = User.new(attrs)
    assert_not user.valid?
    assert_includes user.errors[:password_confirmation], "doesn't match Password"
  end

  test "should be invalid if password confirmation is missing" do
    attrs = valid_user_attributes.except(:password_confirmation)
    user = User.new(attrs)
    assert_not user.valid?
    assert_includes user.errors[:password_confirmation], "doesn't match Password"
  end

  test "should be invalid without password" do
    attrs = valid_user_attributes.except(:password)
    user = User.new(attrs)
    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  test "should be invalid with improperly formatted email" do
    attrs = valid_user_attributes.merge(email: "invalid_email")
    user = User.new(attrs)
    assert_not user.valid?
    assert_includes user.errors[:email], "is invalid"
  end

  test "should be invalid with non-unique email" do
    User.create!(valid_user_attributes)
    user2 = User.new(valid_user_attributes.merge(username: "anotheruser"))
    assert_not user2.valid?
    assert_includes user2.errors[:email], "has already been taken"
  end

  test "should be invalid if password confirmation does not match" do
    attrs = valid_user_attributes.merge(password_confirmation: "different")
    user = User.new(attrs)
    assert_not user.valid?
    assert_includes user.errors[:password_confirmation], "doesn't match Password"
  end
end
