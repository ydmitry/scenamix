require 'spec_helper'

describe AlternativeResponsesController do

  before do
    request.accept = 'application/json'
	end

  describe 'GET show' do
    it 'shows alternative responses' do
      scene = Scene.create! title: 'Title', description: 'Some scene'
      reply_one = Response.create! response: 'Step 0.1.', scene_id: scene.id, parent_id: 0
      reply_two = Response.create! response: 'Step 0.2.', scene_id: scene.id, parent_id: 0

      get :show, scene_id: scene.id, id: reply_one.id

      response.code.should eq '200'
    end
  end

  describe 'POST create' do
    it 'creates alternative response' do
      scene = Scene.create! title: 'Title', description: 'Some scene'
      reply = Response.create! response: 'Step 0.1.', scene_id: scene.id, parent_id: 0

      post :create, scene_id: 1, id: reply.id, response: {response: 'Some action of scenario'}

      response.code.should eq '200'
      scene.responses.last.parent_id.should eq 0
    end

    it 'creates alternative response with parent_id = 0, and not parent_id = nil' do
      scene = Scene.create! title: 'Title', description: 'Some scene'
      reply = Response.create! response: 'Step 0.1.', scene_id: scene.id, parent_id: 0

      post :create, scene_id: 1, id: reply.id, response: {response: 'Some action of scenario'}

      scene.responses.last.parent_id.should eq 0
    end
  end

end
