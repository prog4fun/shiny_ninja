require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { bank_account_number: @user.bank_account_number, bank_name: @user.bank_name, bank_number_code: @user.bank_number_code, city: @user.city, country: @user.country, email: @user.email, firstname: @user.firstname, lastname: @user.lastname, login: @user.login, password: @user.password, phone_number: @user.phone_number, signatur_path: @user.signatur_path, street: @user.street, street_number: @user.street_number, taxnumber: @user.taxnumber, user_types: @user.user_types, zipcode: @user.zipcode }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { bank_account_number: @user.bank_account_number, bank_name: @user.bank_name, bank_number_code: @user.bank_number_code, city: @user.city, country: @user.country, email: @user.email, firstname: @user.firstname, lastname: @user.lastname, login: @user.login, password: @user.password, phone_number: @user.phone_number, signatur_path: @user.signatur_path, street: @user.street, street_number: @user.street_number, taxnumber: @user.taxnumber, user_types: @user.user_types, zipcode: @user.zipcode }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
