require 'spec_helper'

describe Response do
  
  it 'should return alternative responses' do
    scene = create(:scene)
    fork = create(:response, scene: scene)
    turnright = create(:response, scene: scene, parent: fork)
    turnleft = create(:response, scene: scene, parent: fork)

    turnright.alternative.should include turnleft
  end


  it 'should return best scenario for one response' do
    scene = create(:scene)
    response_sport = create(:response, scene: scene, upvotes: 1)
    response_alcohol = create(:response, scene: scene)
    response_sport_gym = create(:response, scene: scene, parent: response_sport, upvotes: 1)
    response_sport_chess = create(:response, scene: scene, parent: response_sport)
    response_alcohol_smoke = create(:response, scene: scene, parent: response_alcohol)

    scenario = response_alcohol.best_scenario
    
    scenario.should include response_alcohol
    scenario.should include response_alcohol_smoke
    scenario.should_not include response_sport
    scenario.should_not include response_sport_chess
    scenario.should_not include response_sport_gym

    scenario = response_sport_chess.best_scenario
    
    scenario.should include response_sport_chess
    scenario.should include response_sport
    scenario.should_not include response_alcohol
    scenario.should_not include response_alcohol_smoke
    scenario.should_not include response_sport_gym
  end
end
