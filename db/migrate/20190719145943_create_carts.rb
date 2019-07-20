class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.integer :userID
      t.string :title
      t.float :price
      t.float :weight
      t.integer :deliveryDays
      t.timestamps
    end
  end
end
