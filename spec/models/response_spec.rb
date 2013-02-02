require 'spec_helper'

describe Response do
  
  it 'should return alternative responses' do
    fork = Response.create!(response: 'Fork', parent_id: 0)
    turnright = Response.create!(response: 'Turn right', parent_id: fork.id)
    turnleft = Response.create!(response: 'Turn left', parent_id: fork.id)

    turnright.alternative.should include turnleft
  end
end
