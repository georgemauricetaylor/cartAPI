require 'test_helper'

class CartTest < ActiveSupport::TestCase

  test "should not save cart without title/price" do
    cart = Cart.new
    assert_not cart.save, "Saved the cart without a title/price"
  end

end
