require 'spec_helper'

describe Scene do

  it 'should return best scenario' do
    scene = Scene.create!(title: 'Good physical form', description: 'How to get good physical form?')
    
    response_sport = Response.create!(response: 'Engage in sports', scene_id: scene.id, parent_id: 0)
    response_sport.weightup

    response_alcohol = Response.create!(response: 'Drink alcohol', scene_id: scene.id, parent_id: 0)
    response_alcohol.weightdown

    response_sport_gym = Response.create!(response: 'Go to gym', scene_id: scene.id, parent_id: response_sport.id)
    response_sport_gym.weightup
    
    response_sport_chess = Response.create!(response: 'Play chess', scene_id: scene.id, parent_id: response_sport.id)
    response_sport_chess.weightdown

    scene.best_scenario.should include response_sport
    scene.best_scenario.should include response_sport_gym
  end

end
