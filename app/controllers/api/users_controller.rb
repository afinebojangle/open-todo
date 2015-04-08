class Api::UsersController < ApiController

  def new
    @user = User.new(api_user_params)
    if @user.save
      success(201, "User Created")
    else
      error(400, "User was not saved")
    end
  end

  def auth
    set_api_user
    if auth_api_user
      success(200, "Welcome Aboard!")
    else
      permission_denied_error
    end
  end
     
    
    
  private

  def api_user_params
    params.permit(:username, :password)
  end
end