require 'spec_helper'

describe Scene do

  it 'should return best scenario' do
    scene = FactoryGirl.create(:scene_physical_form)
    response_sport = FactoryGirl.create(:response_sport)
    response_alcohol = FactoryGirl.create(:response_alcohol)
    response_sport_gym = FactoryGirl.create(:response_sport_gym)
    response_sport_chess = FactoryGirl.create(:response_sport_chess)
    
    scene.best_scenario.should include response_sport_gym
    scene.best_scenario.should include response_sport
  end

end
