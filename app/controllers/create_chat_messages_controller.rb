class CreateChatMessagesController < ApplicationController
  before_action :set_create_chat_message, only: %i[ show update destroy ]

  # GET /create_chat_messages
  def index
    @create_chat_messages = CreateChatMessage.all

    render json: @create_chat_messages
  end

  # GET /create_chat_messages/1
  def show
    render json: @create_chat_message
  end

  # POST /create_chat_messages
  def create
    @create_chat_message = CreateChatMessage.new(create_chat_message_params)

    if @create_chat_message.save
      render json: @create_chat_message, status: :created, location: @create_chat_message
    else
      render json: @create_chat_message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /create_chat_messages/1
  def update
    if @create_chat_message.update(create_chat_message_params)
      render json: @create_chat_message
    else
      render json: @create_chat_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /create_chat_messages/1
  def destroy
    @create_chat_message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_create_chat_message
      @create_chat_message = CreateChatMessage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def create_chat_message_params
      params.fetch(:create_chat_message, {})
    end
end
