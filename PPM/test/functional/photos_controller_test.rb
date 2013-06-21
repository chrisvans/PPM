require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  test "should get photos" do
    get :photos
    assert_response :success
  end

end
