class ScenesController < ApplicationController
  def index
    @scenes = Scene.all
  end

  def new; end

  def create
    @scene = Scene.create!(params[:scene])
    redirect_to @scene, notice: "#{@scene.title} was successfully created."
  end

  def show
    @scene = Scene.find(params[:id])
  end

  def edit
    @scene = Scene.find(params[:id])
  end

  def update
    @scene = Scene.find(params[:id])
    @scene.update_attributes!(params[:scene])
    redirect_to @scene, notice: "#{@scene.title} was successfully updated."
  end

  def destroy
    @scene = Scene.find(params[:id])
    @scene.destroy
    redirect_to scenes_path, notice: "Scene '#{@scene.title}' deleted."
  end
end
