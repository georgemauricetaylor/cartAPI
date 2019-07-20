module Api
  module V1
    class CartController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        #index of all items in the cart.  In later versions with would be amended to only show for checked in user
        cart = Cart.order('created_at DESC')
        render json: {status: 'SUCCESS', message: 'Got Cart', data: cart}, status: :ok
      end

      def create
        userCart = Cart.new(item_params)
        if userCart.save
          render json: {status: "SUCCESS", message: "Cart updated", data: userCart}, status: :ok
        else
          render json: {status: "ERROR", message: "Cart not updated", data: userCart.errors}, status: :unprocessable_entity
        end
      end

      def destory
        userItem = Cart.find(params[:id])
        userItem.destory
        render json: {status: "SUCCESS", message: "Cart item deleted"}, status: :ok
      end

      def remove_all
        userCart = Cart.where(userID: params[:id])
        if userCart.count > 1
          userCart.destroy_all
        end
        render json: {status: "SUCCESS", message: "Cart Emptied"}, status: :ok
      end

      def show
        #this shows a users cart rather than a specific Item.  this can be amended later if needed.
        userCart = Cart.where(userID: params[:id])
        render json: {status: "SUCCESS", message: "Got Users Cart", data: userCart}, status: :ok
      end

      def generate_delivery_from_cart
        #generates a json file with the perfect items in 1 delivery box, when considering weight and delivery date( smaller is better)
        cart = Cart.where(userID: params[:id])
        generate_delivery(cart)
      end

      private

      def generate_delivery(cart)
        # for each item in cart for user add weight and days to set a score of how "good" an item is
        scoringHash = []
        cart.each do |item|
          scoringHash << {
              :id => item.id,
              :score => item.deliveryDays + item.weight,  #score is to sort prefered items, aka shorter delivery times and weight(so more things can be delivered)
              :weight => item.weight,
              :deliveryDays => item.deliveryDays
          }
        end
        scoringHash = scoringHash.sort_by {|x| x[:score]}
        total_weight = 0
        max_weight = 10 # max allowed weight of box
        delivery_time = 0
        delivery_box = []
        scoringHash.each do |product|
          next if product[:weight] + total_weight > max_weight #keep adding items (from best to worst) until weight is achieved. This logic perfers achieving the weight goal over the delivery goal.
          total_weight += product[:weight]
          delivery_box.push(product[:id])
          delivery_time = delivery_time > product[:deliveryDays] ? delivery_time : product[:deliveryDays]
        end
        result = {
            :ID => delivery_box,
            :delivery => delivery_time
        }
        render json: {status: "SUCCESS", message: "Got Users Cart", data: result}, status: :ok
      end

      def item_params
        params.permit(:title, :weight, :price, :userID)
      end
    end
  end
end