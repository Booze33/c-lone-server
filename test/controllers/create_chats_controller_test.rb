require "test_helper"

class CreateChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @create_chat = create_chats(:one)
  end

  test "should get index" do
    get create_chats_url, as: :json
    assert_response :success
  end

  test "should create create_chat" do
    assert_difference("CreateChat.count") do
      post create_chats_url, params: { create_chat: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show create_chat" do
    get create_chat_url(@create_chat), as: :json
    assert_response :success
  end

  test "should update create_chat" do
    patch create_chat_url(@create_chat), params: { create_chat: {  } }, as: :json
    assert_response :success
  end

  test "should destroy create_chat" do
    assert_difference("CreateChat.count", -1) do
      delete create_chat_url(@create_chat), as: :json
    end

    assert_response :no_content
  end
end
