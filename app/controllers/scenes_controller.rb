class ScenesController < ApplicationController
  def index
    @scenes = Scene.all
  end

  def new
  end

  def create
    @scene = Scene.create!(params[:scene])
    flash[:notice] = "#{@scene.title} was successfully created."
    redirect_to scenes_path
  end

  def edit
    @scene = Scene.find params[:id]
  end

  def update
    @scene = Scene.find params[:id]
    @scene.update_attributes!(params[:scene])
    flash[:notice] = "#{@scene.title} was successfully updated."
    redirect_to scene_path(@scene)
  end

  def destroy
    @scene = Scene.find(params[:id])
    @scene.destroy
    flash[:notice] = "Scene '#{@scene.title}' deleted."
    redirect_to scenes_path
  end
end
