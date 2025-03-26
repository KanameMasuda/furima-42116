class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]  # 共通の処理としてset_itemを呼び出す

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  # 共通の処理をまとめたset_itemメソッド
  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(
      :user_id, :item_id, :postal_code, :prefecture_id, 
      :city, :house_number, :phone_number
    )
  end
end
