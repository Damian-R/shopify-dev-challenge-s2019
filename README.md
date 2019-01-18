# Shopify Summer 2019 Backend Developer Intern Challenge
This is my submission for the Shopify Summer 2019 Backend Developer Intern Challenge.

https://damian-reiter-shopify-dev.herokuapp.com

I created the barebones online marketplace using Ruby on Rails.
It supports all the basic functionality requested, as well as a session-based shopping cart, discount codes, and item filtering by category.

The database is re-seeded every hour (at :00) in order to reset the stock of items in case you want to keep testing more :)

# API
> ❗ All endpoints are configured to use HTTP GET. In a real-world scenario, I wouldn't use GET for everything, and I know this doesn't follow best practices. I opted for ease-of-demoability, so all functionality can be explored via a web browser without needing external tools such as Postman ❗

| Endpoint       | Description                       | Parameters (if any)                                                                                                 | Example                                                                                          |
|----------------|-----------------------------------|---------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
| /items         | list all items                    |  available [Boolean]: if true, only show items in stock <br > category [String]: only show items with a specific category |  GET /items?available=true&category=toys |
| /items/:id     | list item with specific id        | N/A                                                                                                                 |  GET /items/1                                                              |
/items/:id/purchase | purchase specific item (cart independent) | N/A | GET /items/1/purchase
| /cart          | show cart metadata and contents   | N/A                                                                                                                 |  GET /cart                                                               |
| /cart/add/:id | add item with specific id to cart | N/A                                                                                                                 |  GET /cart/add/2 |
| /cart/checkout | purchase all items currently in cart | N/A | GET /cart/checkout
/cart/discount/:code | add a discount code to cart. | N/A | GET /cart/discount/25off

# Models
## Item
The `Item` model represents each item for sale.

Schema:
```
  - title: String
  - price: Float
  - inventory_count: Integer
  - category: String
```

## CartItem
The `CartItem` model is simply a reference to a specific `Item` and `Cart`.

A single `Item` can have many `CartItems`. For example:

```
      Item 1
         |
 ------------------------------------
 |                 |                |
CartItem 1        CartItem 2       CartItem 3
 |-- cart_id: 1    |-- cart_id: 4   |-- cart_id: 7
 |-- item_id: 1    |-- item_id: 1   |-- item_id: 1
 |-- quantity: 2   |-- quantity: 1  |-- quantity: 5
```

This shows that carts 1, 4, and 7 each contain varying quantities of Item 1.

Schema:
```
  - item_id: Integer
  - cart_id: Integer
  - quantity: Integer, default => 1
```

## Cart
The `Cart` model is used as a collection of `CartItems`.

Each `Cart` is tied to a user session. On each new session, a new `Cart` will be implicitly created when you access a `/cart` route and will be associated with your current session. Every time you re-visit `/cart`, the controller will display the contents of your active `Cart` tied to your session.

`CartItems` are added to your `Cart` by visiting `/cart/add/:id`, where `id` is the id of the `Item` you wish to add. If your active `Cart` already contains a `CartItem` with `item_id` equal to `id`, it will increase the quantity of that `CartItem` by 1. If not, it will add a new `CartItem` to the `Cart`.

You can checkout your `Cart` by visiting `/cart/checkout`. When you checkout, each `CartItem` in your `Cart` is iterated over. Each `CartItem` has its corresponding `Item`'s `inventory_count` updated to reflect the quantity purchased. `Cart#check_inventory` ensures that a `CartItem`'s `quantity` cannot be greater than the corresponding `Item`'s `inventory_count` due to multiple active `Carts` containing the same items.

Schema:
```
  - subtotal: Float
  - total: Float
  - discount: Float
  - discount_code: String
```

## Discounts
> ❗ note: I just threw this part in for fun, don't feel as though you have to play along, I won't mind :)

I added one discount code which can be applied to your cart by accessing `/cart/discount/:code`.

I recently learned about [CTFs](https://ctfs.github.io/resources/) and was inspired to make a mini-challenge to reveal the discount code =).

The discount code is hidden somewhere in my project (a good place to start looking is in the /config directory).

If you don't want to see if you can find it and just want to test out my discount code functionality, click here to reveal the code ->

<details><summary>reveal code</summary>
code is: chara
</details>
