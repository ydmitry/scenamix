require 'factory_girl'

FactoryGirl.define do
  factory :scene_physical_form, class: Scene do
    title 'Good physical form'
    description 'How to get good physical form?'
  end

  factory :response_sport, class: Response do
    association :scene, factory: :scene_physical_form    
    response 'Engage in sports'
    upvotes 1 
  end

  factory :response_alcohol, class: Response do
    association :scene, factory: :scene_physical_form    
    response 'Drink alcohol'
  end

  factory :response_sport_gym, class: Response do
    association :scene, factory: :scene_physical_form
    association :parent, factory: :response_sport
    response 'Go to gym'
    upvotes 1
  end

  factory :response_sport_chess, class: Response do
    association :scene, factory: :scene_physical_form
    association :parent, factory: :response_sport
    response 'Play chess'    
  end
end
