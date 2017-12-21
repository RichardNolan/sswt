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



#Producer.delete_all
#Product.delete_all

# Test Producers
#producer1 = Producer.create(	name: "Farmer Brown", 
#								email: "fb@abc.com",
#								email_confirmed: true,
#								password: "password",
#								address: "123 crucket road",
#								address2: "Newtown Village",
#								county_id: 1,
#								contact_phone: "123 456 789",
#								contact_email: "fbfb@abc.com",
#								enabled: true
#							)

#producer2 = Producer.create(	name: "Farmer Green", 
#								email: "fb123@abc.com",
#								email_confirmed: true,
#								password: "password",
#								address: "123 Whiskey Bottle",
#								address2: "Village field",
#								county_id: 1,
#								contact_phone: "123 456 789",
#								contact_email: "fbfb123@abc.com",
#								enabled: true
#							)

# Test Products
#producer1.products.create(
#		name: "Sausages",
#		description: "Lots of loveley lovely sausages for your frying pan!",
#		price: 12.99,
#		enabled: true,
#		deleted: false
#	)
#producer1.products.create(
#		name: "Beans",
#		description: "Beans beans good for your heart...",
#		price: 4.99,
#		enabled: true,
#		deleted: false
#	)
#producer1.products.create(
#		name: "Christmas goodies",
#		description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation",
#		price: 20,
#		enabled: true,
#		deleted: false
#	)
#producer1.products.create(
#		name: "Roast beef",
#		description: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
#		price: 4.99,
#		enabled: true,
#		deleted: false
#	)
#producer2.products.create(
#		name: "Candy bar",
#		description: "Suger overload",
#		price: 3,
#		enabled: true,
#		deleted: false
#	)
#producer2.products.create(
#		name: "Potatoes",
#		description: "Chips are cool",
#		price: 6,
#		enabled: true,
#		deleted: false
#	)
#producer2.products.create(
#		name: "Whiskey",
#		description: "Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur",
#		price: 25,
#		enabled: true,
#		deleted: false
#	)
#producer2.products.create(
#		name: "Onions",
#		description: "Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatu",
#		price: 6,
#		enabled: true,
#		deleted: false
#	)

counties = County.create([
    { name: "Antrim" },
    { name: "Armagh" },
    { name: "Carlow" },
    { name: "Cavan" },
    { name: "Clare" },
    { name: "Cork" },
    { name: "Derry" },
    { name: "Donegal" },
    { name: "Down" },
    { name: "Dublin" },
    { name: "Fermanagh" },
    { name: "Galway" },
    { name: "Kerry" },
    { name: "Kildare" },
    { name: "Kilkenny" },
    { name: "Laois" },
    { name: "Leitrim" },
    { name: "Limerick" },
    { name: "Longford" },
    { name: "Louth" },
    { name: "Mayo" },
    { name: "Meath" },
    { name: "Monaghan" },
    { name: "Offaly" },
    { name: "Roscommon" },
    { name: "Sligo" },
    { name: "Tipperary" },
    { name: "Tyrone" },
    { name: "Waterford" },
    { name: "Westmeath" },
    { name: "Wexford" },
    { name: "Wicklow" }
])


Customer.create(id:0, first_name:"UNREGISTERED CUSTOMER",address:"Maple",address2:"Cambará",county_id:15,email:"mauten0@nbcnews.com",password:"fLaT75MXi")