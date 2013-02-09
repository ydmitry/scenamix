require 'spec_helper'

describe Scene do

  it 'should return best scenario' do
    scene = create(:scene)
    response_sport = create(:response, scene: scene, upvotes: 1)
    response_alcohol = create(:response, scene: scene, upvotes: -1)
    response_sport_gym = create(:response, scene: scene, parent: response_sport, upvotes: 1)
    response_sport_chess = create(:response, scene: scene, parent: response_sport)
    response_alcohol_smoke = create(:response, scene: scene, parent: response_alcohol)
    response_alcohol_fastfood = create(:response, scene: scene, parent: response_alcohol)

    scenario = scene.best_scenario
    scenario.should include response_sport_gym
    scenario.should include response_sport
    scenario.should_not include response_alcohol
    scenario.should_not include response_sport_chess
    scenario.should_not include response_alcohol_smoke
    scenario.should_not include response_alcohol_fastfood
  end

  it 'should return best scenario if there is only one response in the scene' do
    scene = create(:scene, title: 'Good physical form', description: 'One man wants to improve his physical form.')
    response_sport = create(:response, scene: scene, response: 'He engages in sports')

    scenario = scene.best_scenario
    scenario.should include response_sport
  end

  it 'should return empty if there is no response in the scene' do
    scene = create(:scene, title: 'Good physical form', description: 'One man wants to improve his physical form.')

    scene.best_scenario.should be_empty
  end

end
