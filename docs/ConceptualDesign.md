# ERD

![our ERD](./ERD.png)
## Assumptions
- Carts are only every generated after user adds a book
- Therefore, Carts must have atleast one book
- A single Book has a single publisher
- All publishers and all persons could have many phone numbers
- Not all Carts will be converted to Checkouts
- All Checkouts are converted to Orders (no failed checkouts)
- A Book can have many Authors
- Authors, Owners, and Customers all share Person attributes
- Owners must request Reports
- An Owner is responsible for fulfilling all orders
- A customer is only added to the DB if they choose to register
- A customer will only be prompted to register at Checkout
- An owner must log in before accessing the owner menu
- A customer can opt not to check out, even after registering
- A customer must be registered in order to Checkout
- An email must belong to one and only one customer. Two people cannot share an email.
- A customer has two addresses attributed to them. A billing and shipping address.
- A checkout also has two addresses, a billing and shipping address.
- A publisher only has one address, their billing address.