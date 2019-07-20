# README

### Ruby version
ruby 2.5.5p157 (2019-03-15 revision 67260) [x86_64-linux]
Rails 5.2.3

###System dependencies
    Docker

###Deployment instructions

* Download project
* Go into the project on the command line
* Run commands:
```
    docker-compose build
    docker-compose up
```
In an other terminator go to the project and run
```
docker-compose run web rails db:setup
docker-compose run web rails db:seed
```
service is now running on 
http://localhost:3000


API endpoints can be found here: 
http://localhost:3000/rails/info/routes


##API Endpoints:


####INDEX
GET http://localhost:3000/api/v1/cart/

Function: Lists all items in the database

Returns:
```
 JSON {
	"status":"SUCCESS",
	"message":"Got Cart",
	"data": << RETURNS ALL ITEMS IN DB>>
	}
```
####CREATE
POST http://localhost:3000/api/v1/cart/
Function: Creates an item in the cart
Expects: 
```
JSON{
	"userID”:<<INT>>,
	”title”:<<STRING>>,
	"price”:<<FLOAT>>,
	"weight”:<<FLOAT>>,
	"deliveryDays”:<<INT>>
	}
```
Returns:

onSuccess
```
JSON {
	"status":"SUCCESS",
	"message”:”Cart updated",
	"data": << RETURNS ITEM CREATED>>
	}
```
onError
```
JSON {
	"status”:”ERROR”,
	"message”:”Cart not updated“,
	"data": << RETURNS ERRORS>>
	}
```

####DESTORY
DELETE http://localhost:3000/api/v1/cart/:id
Function: Removes an item in the cart
Expects: :id of item
Returns:
```
JSON {
	"status":"SUCCESS",
	"message”:”Cart item deleted“
	}
```
####REMOVE_ALL
GET http://localhost:3000/api/v1/cart/remove_all/:id
Function: Removes all items in the cart for a user
Expects: :id of user
Returns:
```
JSON {
	"status":"SUCCESS",
	"message”:”Cart Emptied“
	}
```
####GENERATE_DELIVERY_FROM_CART
GET http://localhost:3000/api/v1/cart/generate_delivery_from_cart/:id
Function: calculates optimal items for delivery box
Expects: User ID of cart
Returns:
```
JSON {
	"status":"SUCCESS",
	"message”:”Cart updated",
	"data": {
		ID: <<Array of item IDS>>
		delivery: <<Int:  time in days delivery will take>>
		}
	}
```

#Next steps:

####database:
take all product informations out of cart (price,weight,title) and have that in a separate table Product
add an amount column to cart so multiple items for the same user arent repeated

###generate_delivery_from_cart:
* return all the boxes needed for the all items in users cart.

* allow user to choose if delivery time or amount of boxes used is more important to them
 