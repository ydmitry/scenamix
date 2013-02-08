require 'spec_helper'

describe Response do
  
  it 'should return alternative responses' do
    scene_id = 1
    fork = Response.create!(response: 'Fork', scene_id: scene_id, parent_id: 0)
    turnright = Response.create!(response: 'Turn right', scene_id: scene_id, parent_id: fork.id)
    turnleft = Response.create!(response: 'Turn left', scene_id: scene_id, parent_id: fork.id)

    turnright.alternative.should include turnleft
  end


  it 'should return best scenario for one response' do
    scene = FactoryGirl.create(:scene_physical_form)
    response_sport = FactoryGirl.create(:response_sport, scene: scene)
    response_alcohol = FactoryGirl.create(:response_alcohol, scene: scene)
    response_sport_gym = FactoryGirl.create(:response_sport_gym, scene: scene, parent: response_sport)
    response_sport_chess = FactoryGirl.create(:response_sport_chess, scene: scene, parent: response_sport)
    response_smoke = FactoryGirl.create(:response_smoke, scene: scene, parent: response_alcohol)

    scenario = response_alcohol.best_scenario
    
    scenario.should include response_alcohol
    scenario.should include response_smoke
    scenario.should_not include response_sport
    scenario.should_not include response_sport_chess
    scenario.should_not include response_sport_gym
  end
end
