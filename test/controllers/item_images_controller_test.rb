require "test_helper"

class ItemImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get item_images_new_url
    assert_response :success
  end

  test "should get index" do
    get item_images_index_url
    assert_response :success
  end

  test "should get show" do
    get item_images_show_url
    assert_response :success
  end

  test "should get edit" do
    get item_images_edit_url
    assert_response :success
  end
end
