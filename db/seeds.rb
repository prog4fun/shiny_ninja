# encoding: UTF-8

# +++++++++++++++++++++++++
# +  Delete               +
# +++++++++++++++++++++++++
Customer.delete_all
Project.delete_all
Report.delete_all
Service.delete_all
User.delete_all

# +++++++++++++++++++++++++
# +  Create               +
# +++++++++++++++++++++++++

# Users
# +++++++++++++++++++++++++
user0 = User.create(
  login: "user0",
  password: "test123",
  firstname: "Seed",
  lastname: "ID",
  email: "user0@mail.de",
  created_by: 2
)
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
  roles_mask: 1,
  created_by: user0.id
)
user2 = User.create(
  login: "cturk",
  password: "test123",
  firstname: "Christopher",
  lastname: "Turk",
  email: "Christopher.Turk@mail.com",
  roles_mask: 1,
  created_by: user1.id
)
user3 = User.create(
  login: "creid",
  password: "test123",
  firstname: "Elliot",
  lastname: "Reid",
  email: "Elliot.Reid@mail.com",
  roles_mask: 2,
  created_by: user2.id
)
user4 = User.create(
  login: "cespinosa",
  password: "test123",
  firstname: "Carla",
  lastname: "Espinosa",
  email: "Carla.Espinosa@mail.com",
  roles_mask: 2,
  created_by: user3.id
)
user5 = User.create(
  login: "pcox",
  password: "test123",
  firstname: "Perry",
  lastname: "Cox",
  email: "Perry.Cox@mail.com",
  roles_mask: 4,
  created_by: user4.id
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


# Services
# +++++++++++++++++++++++++
service1 = Service.create(
  name: "Java",
  wage: 10,
  billable: true,
  comment: "Java programming",
  user_id: user1.id
)
service2 = Service.create(
  name: "C++",
  wage: 15,
  billable: true,
  comment: "C++ programming",
  user_id: user1.id
)
service3 = Service.create(
  name: "Ruby",
  wage: 20,
  billable: true,
  comment: "Ruby programming",
  user_id: user2.id
)
service4 = Service.create(
  name: "HTML",
  wage: 25,
  billable: false,
  comment: "HTML programming",
  user_id: user3.id
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


# Reports
# +++++++++++++++++++++++++
report1 = Report.create(
  date: DateTime.strptime("05/08/2011", "%d/%m/%Y"),
  duration: 2.3,
  comment: "A lot of fun",
  project_id: project1.id,
  service_id: service1.id
)
report2 = Report.create(
  date: DateTime.strptime("10/02/2012", "%d/%m/%Y"),
  duration: 3.74,
  comment: "Great",
  project_id: project2.id,
  service_id: service2.id
)
report3 = Report.create(
  date: DateTime.strptime("15/09/2012", "%d/%m/%Y"),
  duration: 4.25,
  comment: "Boring",
  project_id: project3.id,
  service_id: service3.id
)
report4 = Report.create(
  date: DateTime.strptime("20/12/2014", "%d/%m/%Y"),
  duration: 5.68,
  comment: "What's next?",
  project_id: project4.id,
  service_id: service4.id
)
report5 = Report.create(
  date: DateTime.strptime("04/03/2015", "%d/%m/%Y"),
  duration: 3.70,
  comment: "Looking forward",
  project_id: project4.id,
  service_id: service4.id
)
