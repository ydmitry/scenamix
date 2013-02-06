require 'spec_helper'

describe ResponsesController do
  before do
    request.accept = 'application/json'
  end

  describe 'PUT weightup' do
    it 'increments the response weight' do
      reply = Response.create response: 'Me Gusta.'

      put :weightup, scene_id: 1, id: reply.id

      reply.reload.weight.should eq 1
    end

    it 'returns weight in JSON' do
      reply = Response.create response: 'Me Gusta.'

      put :weightup, scene_id: 1, id: reply.id

      response.body.should == { weight: 1 }.to_json
    end
  end

  describe 'PUT weightdown' do
    it 'decrements the response weight' do
      reply = Response.create response: 'Me Gusta.'

      put :weightdown, scene_id: 1, id: reply.id

      reply.reload.weight.should eq -1
    end

    it 'returns weight in JSON' do
      reply = Response.create response: 'Me Gusta.'

      put :weightdown, scene_id: 1, id: reply.id

      response.body.should == { weight: -1 }.to_json
    end
  end
end
