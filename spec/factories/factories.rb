require 'factory_girl'

FactoryGirl.define do
  factory :scene do
    title 'Some scene title'
    description 'Some scene description.'
  end

  factory :response do
    response 'Some response'
  end
end
