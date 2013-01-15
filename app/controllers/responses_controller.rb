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


  def edit
    @response = Response.find params[:id]
  end

  def update
    @response = Response.find params[:id]
    @scene = Scene.find(@response.scene_id)
    @response.update_attributes!(params[:response])
    flash[:notice] = "#Response was successfully updated."
    redirect_to scene_path(@scene)
  end

  def destroy
    @response = Response.find(params[:id])
    @response.destroy
    flash[:notice] = "Response deleted."
    redirect_to responses_path
  end
end
