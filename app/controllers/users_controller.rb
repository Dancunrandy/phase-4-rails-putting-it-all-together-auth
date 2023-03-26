class UsersController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        render json: { id: user.id, username: user.username, image_url: user.image_url, bio: user.bio }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      if session[:user_id]
        user = User.find_by(id: session[:user_id])
        render json: { id: user.id, username: user.username, image_url: user.image_url, bio: user.bio }, status: :ok
      else
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
  end
  