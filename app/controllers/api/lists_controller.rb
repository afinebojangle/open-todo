class Api::ListsController < ApiController
  def new
    @list = List.new(api_list_params)
    if @list.save
      success(201, "List Created")
    else
      error(400, "List was not saved")
    end
  end

  def add
    set_api_user
    if auth_api_user
      @list = List.new(api_list_params)
      if @list.save
        success(201, "List Added")
      else
        error(400, "List was not saved")
      end
    else
      permission_denied_error
    end
  end

  def remove
    set_api_user
    if auth_api_user
      @list = List.find(params[:list_id])
      if ((@list.user_id == @user.id) && (@list.permissions == "open"))
        @list.destroy
        success(200, "List deleted")
      else
        permission_denied_error
      end
    else
       permission_denied_error
    end
  end

  def changepermissions
    set_api_user
    if auth_api_user
      allowed_permissions = ["open", "private", "viewable"]
      if allowed_permissions.include? params[:permission]
        @list = List.find(params[:list_id])
        if ((@list.user_id == @user.id) && (@list.permissions == "open"))
          @list.update(permissions: params[:permission])
          success(200, "Permission Changed")
        else
          error(400, "Permission was not changed")
        end
      else
        error(400, "Unsupported Permission")
      end
    else
      permission_denied_error
    end
  end

  def index
    set_api_user
    if auth_api_user
      @lists = @user.lists.where(permissions: "viewable")

      render json: @lists, each_serializer: ListsSerializer
    else
      permission_denied_error
    end
  end





  private

  def api_list_params
    params.permit(:name, :user_id, :permissions)
  end
end