FactoryGirl.define do
  factory :account do
    sequence(:name) { |n| "Test account #{n}" }
  end

  factory :user do
    username "tester"
    email "tester@test.com"
    password "secret"
    password_confirmation "secret"
    language "en"
    account
  end

  factory :admin, class: User do
    username "tester_admin"
    email "admin@test.com"
    password "secret"
    password_confirmation "secret"
    admin true
    language "en"
    account
  end

  factory :entry do
    minutes 60
    sequence(:description) { |n| "test description #{n}" }
    date Date.current
  end

  factory :project do
    sequence(:name) { |n| "test project #{n}" }
    account
  end

  factory :ProjectUser do
  end
end
