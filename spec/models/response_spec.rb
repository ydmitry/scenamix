require 'spec_helper'

describe Response do
  
  it 'should return alternative responses' do
    scene_id = 1
    fork = Response.create!(response: 'Fork', scene_id: scene_id, parent_id: 0)
    turnright = Response.create!(response: 'Turn right', scene_id: scene_id, parent_id: fork.id)
    turnleft = Response.create!(response: 'Turn left', scene_id: scene_id, parent_id: fork.id)

    turnright.alternative.should include turnleft
  end

  it 'should weight up' do
    response = Response.create!(response: 'Chuck Norris count to infinity')

    response.weightup.should eq 1
  end

  it 'should weight down' do
    response = Response.create!(response: 'Chuck Norris count to minus infinity')

    response.weightdown.should eq -1
  end
end
