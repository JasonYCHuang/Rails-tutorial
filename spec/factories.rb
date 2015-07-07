FactoryGirl.define do
  factory :user do
    name                  "test_name"
    email                 "test@domain.com"
    password              "foobarfoobar"
    password_confirmation "foobarfoobar"
  end 
end