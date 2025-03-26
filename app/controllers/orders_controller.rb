class OrdersController < ApplicationController
  
  def index
    @item = Item.find(params[:item_id])
    @order_form = Order.new
  end

end
