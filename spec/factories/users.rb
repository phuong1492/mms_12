FactoryGirl.define do
  factory :user do
    sequence :name do |n|
    	"exampleUser#{n}"
    end
    sequence :email do |n|
      "example#{n}@gmail.com"
    end
    password "password"
    password_confirmation "password"
    role "normal"
  end
end
