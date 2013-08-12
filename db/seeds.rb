# encoding: UTF-8

# +++++++++++++++++++++++++
# +  Delete               +
# +++++++++++++++++++++++++
Customer.delete_all
# Project.delete_all
# Report.delete_all
# Service.delete_all
User.delete_all

# +++++++++++++++++++++++++
# +  Create               +
# +++++++++++++++++++++++++

# Users
# +++++++++++++++++++++++++
user1 = User.create(
  login: "mkoriath",
  password: "test123",
  firstname: "MyFirstname",
  lastname: "MyLastname",
  email: "public@koriath-tech.de",
  phone_number: "+49646416",
  street: "MyStreetname",
  street_number: "10c",
  zipcode: "62498",
  city: "MyCityName",
  country: "de",
  bank_name: "MyVeryVeryLoongBankName",
  bank_code: "64351684",
  bank_account_number: "365468131",
  tax_number: "999-888-555",
  signature: "/home/shiny-ninja-data/signature/mkoriath.png",
  roles_mask: 0
)
user2 = User.create(
  login: "cturk",
  password: "test123",
  firstname: "Christopher",
  lastname: "Turk",
  email: "Christopher.Turk@mail.com",
  roles_mask: 0
)
user3 = User.create(
  login: "creid",
  password: "test123",
  firstname: "Elliot",
  lastname: "Reid",
  email: "Elliot.Reid@mail.com",
  roles_mask: 1
)
user4 = User.create(
  login: "cespinosa",
  password: "test123",
  firstname: "Carla",
  lastname: "Espinosa",
  email: "Carla.Espinosa@mail.com",
  roles_mask: 1
)
user5 = User.create(
  login: "pcox",
  password: "test123",
  firstname: "Perry",
  lastname: "Cox",
  email: "Perry.Cox@mail.com",
  roles_mask: 2
)

# Customers
# +++++++++++++++++++++++++
customer1 = Customer.create(
  name: "Homer Simpson",
  email: "Homer.Simpson@mail.de",
  comment: "I love beer",
  user_id: user1.id
)
customer2 = Customer.create(
  name: "Marge Simpson",
  email: "Marge.Simpson@mail.de",
  comment: "Where's the broom?",
  user_id: user1.id
)
customer3 = Customer.create(
  name: "Bart Simpson",
  email: "Bart.Simpson@mail.de",
  comment: "Skateboarding!!",
  user_id: user2.id
)
customer4 = Customer.create(
  name: "Carl Carlson",
  email: "Carl.Carlson@mail.de",
  comment: "I'm boring",
  user_id: user3.id
)
customer5 = Customer.create(
  name: "Rod Flanders",
  email: "Rod.Flanders@mail.de",
  comment: "Go to church",
  user_id: user4.id
)