class StoreController < ApplicationController
	include SessionCount
	include CurrentCart
	before_action :set_cart
  def index
  	@products = Product.order(:title)
  	@count = increase_count
  	@show_message = "You have been here #{@count} times!!" if @count > 5
  end
end
