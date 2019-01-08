# Shopify Summer 2019 Backend Developer Intern Challenge


# API

| Endpoint       | description                       | parameters (if any)                                                                                                 | examples                                                                                          |
|----------------|-----------------------------------|---------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
| /items         | list all items                    |  available [Boolean]: if true, only show items in stock category [String]: only show items with a specific category |  get /items?available=true&category=toys get all items that are in stock and categorized as a toy |
| /items/:id     | list item with specific id        | N/A                                                                                                                 |  get /items/2 get item with id=2                                                                  |
| /cart          | show cart metadata and contents   | N/A                                                                                                                 |  get /cart <add example response>                                                                 |
| /addtocart/:id | add item with specific id to cart | N/A                                                                                                                 |  get /addtocart/2 add item with id=2 to cart (or increase quantity by 1 if already present)       |
