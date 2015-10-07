require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
	test "product attribute must not be empty" do 
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?
	end

	test "product price must be positive" do
		product = Product.new(title: "My Book Title", description: "yyy", image_url: "zzz.jpg")

		product.price = -1
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

		product.price = 0
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]		

		product.price = 1
		assert product.valid?
	end

	def new_product(image_url)
		Product.new(title: "My Book title", description: "yyy", price: 1, image_url: image_url)
	end

	test "product image_url" do
		ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.PnG http://a/b/c/d.jpg}
		bad = %w{fred.doc fred.gif/more fred.gif.doc}
		ok.each do|name|
			assert new_product(name).valid?, "#{name} must be valid"
		end
		bad.each do|name|
			assert new_product(name).invalid?, "#{name} must be invalid"
		end
	end

	test "product is not valid without a unique title" do
		product = Product.new(	title: 			products(:ruby).title, 
								description: 	"yyy", 
								image_url: 		"fred.gif", 
								price: 			1)
		assert product.invalid?
		assert_equal ["has already been taken"], product.errors[:title]
	end

	test "product title lenght should be 10 or more" do
		product = Product.new( 	title: 			"tiny",
								description: 	"yyy",
								image_url: 		"fred.gif",
								price: 			1)
		assert product.invalid?
		assert_equal ["length less that 10 not allowed"], product.errors[:title]
	end
end  