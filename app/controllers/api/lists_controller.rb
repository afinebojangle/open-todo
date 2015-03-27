class Api::ListsController < ApiController
  def new
    @list = List.new(api_list_params)
    if @list.save
      success(201, "List Created")
    else
      error(400, "List was not saved")
    end
  end

  private

  def api_list_params
    params.permit(:name, :user_id, :permissions)
  end
end