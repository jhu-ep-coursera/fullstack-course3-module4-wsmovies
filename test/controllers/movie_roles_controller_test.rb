require 'test_helper'

class MovieRolesControllerTest < ActionController::TestCase
  setup do
    @movie_role = movie_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_role" do
    assert_difference('MovieRole.count') do
      post :create, movie_role: { actor_id: @movie_role.actor_id, character: @movie_role.character }
    end

    assert_redirected_to movie_role_path(assigns(:movie_role))
  end

  test "should show movie_role" do
    get :show, id: @movie_role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_role
    assert_response :success
  end

  test "should update movie_role" do
    patch :update, id: @movie_role, movie_role: { actor_id: @movie_role.actor_id, character: @movie_role.character }
    assert_redirected_to movie_role_path(assigns(:movie_role))
  end

  test "should destroy movie_role" do
    assert_difference('MovieRole.count', -1) do
      delete :destroy, id: @movie_role
    end

    assert_redirected_to movie_roles_path
  end
end
