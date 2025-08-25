class UsersController < ApplicationController
  before_action find_user_by_id, only: %i[ edit update ]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def find_user_by_id
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
