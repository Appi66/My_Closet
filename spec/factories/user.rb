FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 30) }
    password { 'password' }
    password_confirmation { 'password' }
    
    after(:build) do |user|
      user.profile_image.attach(io: File.open('spec/images/no_image.jpg'), filename: 'no_image.jpg', content_type: 'application/xlsx')
    end
  end
end