class ScenesController < ApplicationController
  def index
    @scenes = Scene.ordered
  end

  def new
    @scene = Scene.new
  end

  def create
    params_scene = params[:scene]

    @scene = Scene.new do |scene|
      scene.title = params_scene[:title]
      scene.description = params_scene[:description]
      scene.user_id = current_user.try(:id)
      scene.ip_address = request.remote_ip
    end

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

    if !current_user.try(:admin?) && current_user.try(:id) != @scene.user_id
      raise "Scene can be edited only by owner or admin."
    end

    if @scene.update_attributes(params[:scene])
      redirect_to @scene, notice: "#{@scene.title} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @scene = Scene.find(params[:id])

    if !current_user.try(:admin?) && current_user.try(:id) != @scene.user_id
      raise "Response can be deleted only by owner or admin."
    end

    @scene.destroy
    redirect_to scenes_path, notice: "Scene '#{@scene.title}' deleted."
  end
end
