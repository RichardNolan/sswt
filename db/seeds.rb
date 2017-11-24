# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create example Categories
#Category.create([
#	{name: "Sweets"},
#	{name: "Chocolate"},
#	{name: "Turkey"},
#	{name: "Pudding"}
#])



# Test Producers
producer1 = Producer.create(	name: "Farmer Brown", 
								email: "fb@abc.com",
								email_confirmed: true,
								password: "password",
								address: "123 crucket road",
								address2: "Newtown Village",
								county_id: 1,
								contact_phone: "123 456 789",
								contact_email: "fbfb@abc.com",
								enabled: true
							)

producer2 = Producer.create(	name: "Farmer Green", 
								email: "fb123@abc.com",
								email_confirmed: true,
								password: "password",
								address: "123 Whiskey Bottle",
								address2: "Village field",
								county_id: 1,
								contact_phone: "123 456 789",
								contact_email: "fbfb123@abc.com",
								enabled: true
							)


# Test Products
producer1.products.create(
		name: "Sausages",
		description: "Lots of loveley lovely sausages for your frying pan!",
		price: 12.99,
		enabled: true,
		deleted: false
	)
producer1.products.create(
		name: "Beans",
		description: "Beans beans good for your heart...",
		price: 4.99,
		enabled: true,
		deleted: false
	)
producer2.products.create(
		name: "Candy bar",
		description: "Suger overload",
		price: 3,
		enabled: true,
		deleted: false
	)
producer2.products.create(
		name: "Potatoes",
		description: "Chips are cool",
		price: 6,
		enabled: true,
		deleted: false
	)