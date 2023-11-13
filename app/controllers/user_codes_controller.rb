# app/controllers/user_codes_controller.rb
class UserCodesController < ApplicationController
  before_action :set_user_code, only: %i[show update destroy]

  def index
    @user_codes = current_user.user_codes
    render json: @user_codes
  end

  def show
    render json: @user_code
  end

  def create
    @user_code = current_user.user_codes.new(user_code_params)

    prompt = "Assist me in writing code to: #{params[:user_code][:programming_language]}"
    suggestion = OpenaiService.generate_code_suggestion(prompt)

    @user_code.code_content = suggestion

    if @user_code.save
      CodeExecutionWorker.perform_async(@user_code.id)
      
      render json: @user_code, status: :created
    else
      render json: @user_code.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user_code.update(user_code_params)
      render json: @user_code
    else
      render json: @user_code.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user_code.destroy
    head :no_content
  end

  private

  def set_user_code
    @user_code = current_user.user_codes.find(params[:id])
  end

  def user_code_params
    params.require(:user_code).permit(:programming_language, :code_content)
  end
end
