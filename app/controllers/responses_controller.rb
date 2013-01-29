class ResponsesController < ApplicationController
  def create
    scene = Scene.find(params[:scene_id])
    scene.responses.create!(params[:response])
    redirect_to scene, notice: "Response to #{scene.title} was successfully posted."
  end

  def edit
    @response = Response.find(params[:id])
  end

  def update
    response = Response.find(params[:id])
    response.update_attributes!(params[:response])
    redirect_to response.scene, notice: "#Response was successfully updated."
  end

  def destroy
    response = Response.find(params[:id])
    response.destroy
    redirect_to response.scene, notice: "Response deleted."
  end
end
