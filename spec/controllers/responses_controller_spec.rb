require 'spec_helper'

describe ResponsesController do

  context 'request JSON' do
    before do
      request.accept = 'application/json'
    end

    describe 'PUT upvote' do
      it 'increments the response upvotes' do
        scene = Scene.create! title: 'Title', description: 'Some scene'
        reply = Response.create! scene_id: scene.id, response: 'Me Gusta.'

        put :upvote, scene_id: 1, id: reply.id

        reply.reload.upvotes.should eq 1
      end

      it 'returns votes in JSON' do
        scene = Scene.create! title: 'Title', description: 'Some scene'
        reply = Response.create! scene_id: scene.id, response: 'Me Gusta.'

        put :upvote, scene_id: 1, id: reply.id

        response.body.should == { votes: 1 }.to_json
      end
    end

    describe 'PUT downvote' do
      it 'increments the response downvotes' do
        scene = Scene.create! title: 'Title', description: 'Some scene'
        reply = Response.create! scene_id: scene.id, response: 'Me Gusta.'

        put :downvote, scene_id: 1, id: reply.id

        reply.reload.downvotes.should eq 1
      end

      it 'returns votes in JSON' do
        scene = Scene.create! title: 'Title', description: 'Some scene'
        reply = Response.create! scene_id: scene.id, response: 'Me Gusta.'

        put :downvote, scene_id: 1, id: reply.id

        response.body.should == { votes: -1 }.to_json
      end
    end

    describe 'GET show' do
      it 'should show response scenario' do
        scene = Scene.create! title: 'Title', description: 'Some scene'
        reply = Response.create! scene_id: scene.id, response: 'Some scenario step 1'

        get :show, id: reply.id, scene_id: scene.id

        response.code.should eq '200'
      end
    end
  end

  context 'request HTML' do
    before do
      request.accept = 'text/html'
    end

    describe 'GET show' do
      it 'should show response scenario' do
        scene = Scene.create! title: 'Title', description: 'Some scene'
        reply = Response.create! scene_id: scene.id, response: 'Some scenario step 1'

        get :show, id: reply.id, scene_id: scene.id

        response.code.should eq '200'
      end
    end
  end

end
