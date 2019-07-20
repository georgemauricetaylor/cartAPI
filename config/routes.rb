Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :cart
      get "cart/remove_all/:id" => "cart#remove_all"
      get "cart/generate_delivery_from_cart/:id" => "cart#generate_delivery_from_cart"
    end
  end
end
