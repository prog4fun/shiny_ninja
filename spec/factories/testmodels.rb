# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :testmodel do
    teststring "MyString"
    testcheck false
    testnumber ""
  end
end
