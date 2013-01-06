class ResponsesController < ApplicationController
  def new
  end

  def create
    @scene = Scene.find(params[:scene_id])
    params_response = params[:response]
    params_response[:scene_id] = params[:scene_id]
    @response = Response.create!(params_response)
      
    flash[:notice] = "Response to #{@scene.title} was successfully posted."
    redirect_to scene_path(@scene)
  end
end
