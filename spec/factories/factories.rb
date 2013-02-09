require 'factory_girl'

FactoryGirl.define do
  factory :scene_physical_form, class: Scene do
    title 'Good physical form'
    description 'One man wants to improve his physical form.'
  end

  factory :response_sport, class: Response do
    association :scene, factory: :scene_physical_form    
    response 'He engages in sports'
    upvotes 1
  end

  factory :response_alcohol, class: Response do
    association :scene, factory: :scene_physical_form    
    response 'He begin to drink alcohol'
    upvotes -1
  end

  factory :response_smoke, class: Response do
    association :scene, factory: :scene_physical_form    
    response 'And smoke cigarettes'
    upvotes -1
  end

  factory :response_fastfood, class: Response do
    association :scene, factory: :scene_physical_form    
    response 'Or eat fastfood'
    upvotes -1
  end

  factory :response_sport_gym, class: Response do
    association :scene, factory: :scene_physical_form
    association :parent, factory: :response_sport
    response 'He go to gym and improves'
    upvotes 2
  end

  factory :response_sport_chess, class: Response do
    association :scene, factory: :scene_physical_form
    association :parent, factory: :response_sport
    response 'And play chess. Not improves, but not worsen'
    upvotes 1
  end
end
