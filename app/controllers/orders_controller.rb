class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create] # 共通の処理としてset_itemを呼び出す

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
    @items = Item.where.not(status: 'sold_out')
  end

  def create
    @item = Item.find(params[:item_id]) # 商品情報を取得
    @order_address = OrderAddress.new(order_params)
    @order_address.user_id = current_user.id
    @order_address.item_id = params[:item_id]

    if @order_address.valid?
      pay_item
      @order_address.save
      mark_item_as_sold
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

  def mark_item_as_sold
    @item.update(sold_out: true)
  end
end
