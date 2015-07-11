FactoryGirl.define do  
  factory :relationship do
    follower_id 1
    followed_id 1
  end

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password 			  "foobarfoobar"
    password_confirmation "foobarfoobar"
    confirmed_at          "2015-07-09"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end