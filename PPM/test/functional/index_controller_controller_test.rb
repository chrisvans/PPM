require 'test_helper'

class IndexControllerControllerTest < ActionController::TestCase
  test "should get ProfileController" do
    get :ProfileController
    assert_response :success
  end

  test "should get CurriculumController" do
    get :CurriculumController
    assert_response :success
  end

end
