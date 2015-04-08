class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token

  respond_to :json

  private

  def set_api_user
    @user = User.find(params[:user_id])
  end

  def auth_api_user
    @user.password == params[:password]
  end

  def permission_denied_error
    error(403, 'Permission Denied!')
  end

  def error(status, message)
    response = {
      response_type: "Error",
      message: message
    }

    render json: response.to_json, status: status
  end

  def success(status, message)
    response = {
      response_type: "Success",
      message: message
    }
    
    render json: response.to_json, status: status
  end
end