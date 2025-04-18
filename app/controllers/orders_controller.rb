class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create] 
  before_action :redirect_if_sold_out, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
    @items = Item.where.not(status: 'sold_out')
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @order_address.user_id = current_user.id
    @order_address.item_id = params[:item_id]

    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_sold_out
    if @item.sold_out? || current_user.id == @item.user_id
      redirect_to root_path
    end
  end


  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :addresses,
      :building, :phone_number
    ).merge(
      token: params[:token],
      user_id: current_user.id,
      item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,             # 商品の値段を直接取得
      card: order_params[:token],      # カードトークン
      currency: 'jpy'                  # 通貨の種類（日本円）
    )
  end

end
