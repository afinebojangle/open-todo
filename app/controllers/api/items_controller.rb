class Api::ItemsController < ApiController

  def new
    @item = Item.new(api_item_params)
    if @item.save
      success(201, "Item Created")
    else
      error(400, "Item was not saved")
    end
  end

  private

  def api_item_params
    params.permit(:description, :list_id)
  end

end