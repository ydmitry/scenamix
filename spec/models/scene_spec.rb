require 'spec_helper'

describe Scene do

  it 'should return best scenario' do
    scene = FactoryGirl.create(:scene_physical_form)
    response_sport = FactoryGirl.create(:response_sport, scene: scene)
    response_alcohol = FactoryGirl.create(:response_alcohol, scene: scene)
    response_sport_gym = FactoryGirl.create(:response_sport_gym, scene: scene, parent: response_sport)
    response_sport_chess = FactoryGirl.create(:response_sport_chess, scene: scene, parent: response_sport)
    response_smoke = FactoryGirl.create(:response_smoke, scene: scene, parent: response_alcohol)
    response_fastfood = FactoryGirl.create(:response_fastfood, scene: scene, parent: response_alcohol)

    scenario = scene.best_scenario
    scenario.should include response_sport_gym
    scenario.should include response_sport
    scenario.should_not include response_alcohol
    scenario.should_not include response_sport_chess
    scenario.should_not include response_smoke
    scenario.should_not include response_fastfood
  end

  it 'should return best scenario if there is only one response in the scene' do
    scene = FactoryGirl.create(:scene_physical_form)
    response_sport = FactoryGirl.create(:response_sport, scene: scene)

    scenario = scene.best_scenario
    scenario.should include response_sport
  end

end
