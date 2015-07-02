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
    birthday = Time.zone.now
    role "normal"
  end

  factory :invalid_user, parent: :user do |b|
    b.email nil
  end
end
