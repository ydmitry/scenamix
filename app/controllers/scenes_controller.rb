class ScenesController < ApplicationController
  def index
    @scenes = Scene.ordered
  end

  def new
    @scene = Scene.new
  end

  def create
    @scene = Scene.new(params[:scene])

    if @scene.save
      redirect_to @scene, notice: "#{@scene.title} was successfully created."
    else
      render :new
    end
  end

  def show
    @scene = Scene.find(params[:id])
    @scenario = @scene.best_scenario
  end

  def edit
    @scene = Scene.find(params[:id])
  end

  def update
    @scene = Scene.find(params[:id])

    if !current_user.try(:admin?)
      raise "Scene can be edited only by admin."
    end

    if @scene.update_attributes(params[:scene])
      redirect_to @scene, notice: "#{@scene.title} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @scene = Scene.find(params[:id])

    if !current_user.try(:admin?)
      raise "Response can be deleted only by admin."
    end

    @scene.destroy
    redirect_to scenes_path, notice: "Scene '#{@scene.title}' deleted."
  end
end
