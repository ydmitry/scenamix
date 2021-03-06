require 'spec_helper'

describe Scene do
  describe '#best_scenario' do
    it 'returns best scenario' do
      scene = create(:scene)
      response_sport = create(:response, scene: scene, upvotes: 1)
      response_alcohol = create(:response, scene: scene, upvotes: -1)
      response_sport_gym = create(:response, scene: scene, parent: response_sport, upvotes: 1)
      response_sport_chess = create(:response, scene: scene, parent: response_sport)
      response_alcohol_smoke = create(:response, scene: scene, parent: response_alcohol)
      response_alcohol_fastfood = create(:response, scene: scene, parent: response_alcohol)

      scene.best_scenario.should == [response_sport, response_sport_gym]
    end

    it 'returns best scenario if there is only one response in the scene' do
      scene = create(:scene, title: 'Good physical form', description: 'One man wants to improve his physical form.')
      response_sport = create(:response, scene: scene, response: 'He engages in sports')

      scene.best_scenario.should include response_sport
    end

    it 'returns empty if there is no response in the scene' do
      scene = create(:scene, title: 'Good physical form', description: 'One man wants to improve his physical form.')

      scene.best_scenario.should be_empty
    end
  end

  describe '#scenarios_response_ids' do
    it 'returns scenarios' do
      scene = create(:scene)
      response_sport = create(:response, scene: scene, upvotes: 1)
      response_alcohol = create(:response, scene: scene, upvotes: -1)
      response_sport_gym = create(:response, scene: scene, parent: response_sport, upvotes: 1)
      response_sport_chess = create(:response, scene: scene, parent: response_sport)
      response_alcohol_smoke = create(:response, scene: scene, parent: response_alcohol)
      response_alcohol_fastfood = create(:response, scene: scene, parent: response_alcohol, upvotes: 1)

      scene.scenarios_response_ids.should == [response_sport_gym, response_sport_chess, response_alcohol_fastfood, response_alcohol_smoke].map(&:id)
    end
  end
end
