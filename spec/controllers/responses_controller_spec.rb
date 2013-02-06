require 'spec_helper'

describe ResponsesController do
  before do
    request.accept = 'application/json'
  end

  describe 'PUT upvote' do
    it 'increments the response upvotes' do
      reply = Response.create response: 'Me Gusta.'

      put :upvote, scene_id: 1, id: reply.id

      reply.reload.upvotes.should eq 1
    end

    it 'returns votes in JSON' do
      reply = Response.create response: 'Me Gusta.'

      put :upvote, scene_id: 1, id: reply.id

      response.body.should == { upvotes: 1, downvotes: 0 }.to_json
    end
  end

  describe 'PUT downvote' do
    it 'increments the response downvotes' do
      reply = Response.create response: 'Me Gusta.'

      put :downvote, scene_id: 1, id: reply.id

      reply.reload.downvotes.should eq 1
    end

    it 'returns votes in JSON' do
      reply = Response.create response: 'Me Gusta.'

      put :downvote, scene_id: 1, id: reply.id

      response.body.should == { upvotes: 0, downvotes: 1 }.to_json
    end
  end
end
