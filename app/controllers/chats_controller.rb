class ChatsController < ApplicationController
  before_action :set_create_chat, only: %i[ show update destroy ]

  # GET /create_chats
  def index
    @create_chats = CreateChat.all

    render json: @create_chats
  end

  # GET /create_chats/1
  def show
    render json: @create_chat
  end

  # POST /create_chats
  def create
    @create_chat = CreateChat.new(create_chat_params)

    if @create_chat.save
      render json: @create_chat, status: :created, location: @create_chat
    else
      render json: @create_chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /create_chats/1
  def update
    if @create_chat.update(create_chat_params)
      render json: @create_chat
    else
      render json: @create_chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /create_chats/1
  def destroy
    @create_chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_create_chat
      @create_chat = CreateChat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def create_chat_params
      params.fetch(:create_chat, {})
    end
end
