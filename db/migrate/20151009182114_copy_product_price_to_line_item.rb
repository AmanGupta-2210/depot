class CopyProductPriceToLineItem < ActiveRecord::Migration
  def change
  	add_column :line_items, :product_price, :decimal
  	LineItem.all.each do |line_item|
  		product = Product.find(line_item.product_id)
  		line_item.product_price = product.price
  	end
  end
end
