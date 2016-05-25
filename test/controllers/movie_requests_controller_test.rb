require 'test_helper'

class MovieRequestsControllerTest < ActionController::TestCase
  setup do
    @movie_request = movie_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_request" do
    assert_difference('MovieRequest.count') do
      post :create, movie_request: { poster: @movie_request.poster, title: @movie_request.title, year: @movie_request.year }
    end

    assert_redirected_to movie_request_path(assigns(:movie_request))
  end

  test "should show movie_request" do
    get :show, id: @movie_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_request
    assert_response :success
  end

  test "should update movie_request" do
    patch :update, id: @movie_request, movie_request: { poster: @movie_request.poster, title: @movie_request.title, year: @movie_request.year }
    assert_redirected_to movie_request_path(assigns(:movie_request))
  end

  test "should destroy movie_request" do
    assert_difference('MovieRequest.count', -1) do
      delete :destroy, id: @movie_request
    end

    assert_redirected_to movie_requests_path
  end
end
