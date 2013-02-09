require 'spec_helper'

describe Response do
  
  it 'does return alternative responses' do
    scene = create(:scene)
    fork = create(:response, scene: scene)
    turnright = create(:response, scene: scene, parent: fork)
    turnleft = create(:response, scene: scene, parent: fork)

    turnright.alternative.should include turnleft
    turnright.alternative.should_not include turnright
  end


  it 'does return best scenario for one response' do
    scene = create(:scene)
    response_sport = create(:response, scene: scene, upvotes: 1)
    response_alcohol = create(:response, scene: scene)
    response_sport_gym = create(:response, scene: scene, parent: response_sport, upvotes: 1)
    response_sport_chess = create(:response, scene: scene, parent: response_sport)
    response_alcohol_smoke = create(:response, scene: scene, parent: response_alcohol)
    response_alcohol_smoke_fastfood = create(:response, scene: scene, parent: response_alcohol_smoke)

    response_alcohol.best_scenario.should == [response_alcohol, response_alcohol_smoke, response_alcohol_smoke_fastfood]

    response_sport_chess.best_scenario.should == [response_sport, response_sport_chess]

    response_alcohol_smoke_fastfood.best_scenario.should == [
      response_alcohol, response_alcohol_smoke, response_alcohol_smoke_fastfood
    ]
  end
end
