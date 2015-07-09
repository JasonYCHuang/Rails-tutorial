FactoryGirl.define do
  factory :user do
    name                  "test_name"
    email                 "test@domain.com"
    password              "foobarfoobar"
    password_confirmation "foobarfoobar"
    confirmed_at          "2015-07-09"
  end 
end