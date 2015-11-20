require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:quoc)
  end

  test "unsuccesfull edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "",
                          email: "foo@invalid",
                          password: "foo",
                          password_confirmation: "bar" }
    assert_template 'users/edit'
  end

  test "succesfull edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Quoc Bui"
    email = "quoc@gmail.com"
    patch user_path(@user), user: { name: name,
                          email: email,
                          password: "",
                          password_confirmation: ""}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
