module Api
  class Api::UsersController < ApiController
    def create
      @user = User.new(user_params)
    end
      
    
    
    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
  end
end