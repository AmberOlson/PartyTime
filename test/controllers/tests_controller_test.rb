require 'test_helper'

class TestsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "fails upon not logging in" do
    get :index
    assert_response :redirect
  end

end
