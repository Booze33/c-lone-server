require "test_helper"

class CreateChatMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @create_chat_message = create_chat_messages(:one)
  end

  test "should get index" do
    get create_chat_messages_url, as: :json
    assert_response :success
  end

  test "should create create_chat_message" do
    assert_difference("CreateChatMessage.count") do
      post create_chat_messages_url, params: { create_chat_message: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show create_chat_message" do
    get create_chat_message_url(@create_chat_message), as: :json
    assert_response :success
  end

  test "should update create_chat_message" do
    patch create_chat_message_url(@create_chat_message), params: { create_chat_message: {  } }, as: :json
    assert_response :success
  end

  test "should destroy create_chat_message" do
    assert_difference("CreateChatMessage.count", -1) do
      delete create_chat_message_url(@create_chat_message), as: :json
    end

    assert_response :no_content
  end
end
