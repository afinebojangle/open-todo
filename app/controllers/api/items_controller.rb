class Api::ItemsController < ApiController

  def new
    @item = Item.new(api_item_params)
    if @item.save
      success(201, "Item Created")
    else
      error(400, "Item was not saved")
    end
  end

  def add
    set_api_user
    if auth_api_user
      @item = Item.new(api_item_params)
      if @item.save
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
      @item = Item.find_by(description: params[:description])
      @list = List.find(params[:list_id])
      if ((@list.user_id == @user.id) && (@list.permissions == "open"))
        @item.mark_complete
        success(200, "item item completed")
      else
        error(403, "Not your item!")
      end
    else
       permission_denied_error
    end
  end

  private

  def api_item_params
    params.permit(:description, :list_id)
  end

end