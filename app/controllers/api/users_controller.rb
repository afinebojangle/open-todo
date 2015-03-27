class Api::UsersController < ApiController

  def new
    @user = User.new(api_user_params)
    if @user.save
      success(201, "User Created")
    else
      error(400, "User was not saved")
    end
  end
     
    
    
  private

  def set_user
    @user = User.find(params[:id])
  end

  def api_user_params
    params.permit(:username, :password)
  end
end