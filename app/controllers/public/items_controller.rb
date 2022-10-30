class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.page(params[:page]).per(10)
  end
  
  def 
    @item = Item.find(params[:id])
  end

end
