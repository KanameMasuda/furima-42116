class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order = Order.new(item_id: @item.id)
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end


  private

  def order_params
    params.require(:order).permit(
      :user_id, :item_id, :postal_code, :prefecture_id, 
      :city, :house_number, :phone_number
    )
  end
end
