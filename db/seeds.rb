# encoding: UTF-8

# +++++++++++++++++++++++++
# +  Delete               +
# +++++++++++++++++++++++++
Customer.delete_all
Project.delete_all
ProjectsUser.delete_all
Report.delete_all
Service.delete_all
User.delete_all

# +++++++++++++++++++++++++
# +  Create               +
# +++++++++++++++++++++++++

# Users
# +++++++++++++++++++++++++
user1 = User.create(
  login: "testuser",
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
  signature: "/home/shiny-ninja-data/signature/mkoriath.png",
  roles_mask: 1,
  confirmed_at: DateTime.now
)
user2 = User.create(
  login: "cturk",
  password: "test123",
  firstname: "Christopher",
  lastname: "Turk",
  email: "Christopher.Turk@mail.com",
  roles_mask: 1,
  confirmed_at: DateTime.now
)
user3 = User.create(
  login: "creid",
  password: "test123",
  firstname: "Elliot",
  lastname: "Reid",
  email: "Elliot.Reid@mail.com",
  roles_mask: 2,
  confirmed_at: DateTime.now
)
user4 = User.create(
  login: "cespinosa",
  password: "test123",
  firstname: "Carla",
  lastname: "Espinosa",
  email: "Carla.Espinosa@mail.com",
  roles_mask: 2,
  confirmed_at: DateTime.now
)
user5 = User.create(
  login: "pcox",
  password: "test123",
  firstname: "Perry",
  lastname: "Cox",
  email: "Perry.Cox@mail.com",
  roles_mask: 4,
  confirmed_at: DateTime.now
)

# Customers
# +++++++++++++++++++++++++
customer1 = Customer.create(
  name: "Homer Simpson",
  email: "Homer.Simpson@mail.de",
  comment: "I love beer",
  user_id: user3.id
)
customer2 = Customer.create(
  name: "Marge Simpson",
  email: "Marge.Simpson@mail.de",
  comment: "Where's the broom?",
  user_id: user3.id
)
customer3 = Customer.create(
  name: "Bart Simpson",
  email: "Bart.Simpson@mail.de",
  comment: "Skateboarding!!",
  user_id: user3.id
)
customer4 = Customer.create(
  name: "Carl Carlson",
  email: "Carl.Carlson@mail.de",
  comment: "I'm boring",
  user_id: user4.id
)
customer5 = Customer.create(
  name: "Rod Flanders",
  email: "Rod.Flanders@mail.de",
  comment: "Go to church",
  user_id: user4.id
)


# Services
# +++++++++++++++++++++++++
service1 = Service.create(
  name: "Java",
  wage: 10,
  billable: true,
  comment: "Java programming",
  user_id: user3.id
)
service2 = Service.create(
  name: "C++",
  wage: 15,
  billable: true,
  comment: "C++ programming",
  user_id: user3.id
)
service3 = Service.create(
  name: "Ruby",
  wage: 20,
  billable: true,
  comment: "Ruby programming",
  user_id: user3.id
)
service4 = Service.create(
  name: "HTML",
  wage: 25,
  billable: false,
  comment: "HTML programming",
  user_id: user4.id
)
service5 = Service.create(
  name: "JavaScript",
  wage: 30,
  billable: false,
  comment: "JavaScript programming",
  user_id: user4.id
)


# Projects
# +++++++++++++++++++++++++
project1 = Project.create(
  name: "Mobile",
  timebudget: 100,
  comment: "Mobile development",
  customer_id: customer1.id
)
project2 = Project.create(
  name: "Browser",
  timebudget: 200,
  comment: "Browser development",
  customer_id: customer2.id
)
project3 = Project.create(
  name: "Tablet",
  timebudget: 300,
  comment: "Tablet development",
  customer_id: customer3.id
)
project4 = Project.create(
  name: "Event",
  timebudget: 400,
  comment: "Event application programming",
  customer_id: customer4.id
)
project5 = Project.create(
  name: "iOS",
  timebudget: 400,
  comment: "iOS application programming",
  customer_id: customer5.id
)


# Reports
# +++++++++++++++++++++++++
20.times do
Report.create(
  date: rand(1...90).days.ago,
  duration: rand(1...10)*1.25,
  comment: "A lot of fun!",
  project_id: project1.id,
  service_id: service1.id
)
end
20.times do
Report.create(
  date: rand(1...90).days.ago,
  duration: rand(1...10)*1.75,
  comment: "A lot of fun!!",
  project_id: project2.id,
  service_id: service2.id
)
end
20.times do
Report.create(
  date: rand(1...90).days.ago,
  duration: rand(1...10)*1.50,
  comment: "A lot of fun!!!",
  project_id: project3.id,
  service_id: service3.id
)
end
30.times do
Report.create(
  date: rand(1...90).days.ago,
  duration: rand(1...10)*1.75,
  comment: "A lot of fun!",
  project_id: project4.id,
  service_id: service4.id
)
end
30.times do
Report.create(
  date: rand(1...90).days.ago,
  duration: rand(1...10)*1.75,
  comment: "A lot of fun!!",
  project_id: project5.id,
  service_id: service5.id
)
end