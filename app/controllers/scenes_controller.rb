class ScenesController < ApplicationController
  def index
    @scenes = Scene.find_user_scenes(current_user.id)
  end

  def new
    @scene = Scene.new
  end

  def create
    @scene = Scene.new(scene_fields)
    @scene.user = current_user
    @scene.ip_address = request.remote_ip

    if !current_user.try(:id)
      raise "Scene can be created only by user."
    end

    if @scene.save
      redirect_to @scene, notice: "#{@scene.title} was successfully created. Wait until other users share their imagination or invite friends by sending them the link to a scene."
    else
      render :new
    end
  end

  def show
    @scene = Scene.find(params[:id])
  end

  def edit
    @scene = Scene.find(params[:id])
  end

  def update
    @scene = Scene.find(params[:id])

    if !current_user.try(:id)
      raise "Scene can be edited only by user."
    end

    if !current_user.try(:admin?) && current_user.try(:id) != @scene.user_id
      raise "Scene can be edited only by owner or admin."
    end

    if @scene.update_attributes(scene_fields)
      redirect_to @scene, notice: "#{@scene.title} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @scene = Scene.find(params[:id])

    if !current_user.try(:id)
      raise "Scene can be deleted only by user."
    end

    if !current_user.try(:admin?) && current_user.try(:id) != @scene.user_id
      raise "Response can be deleted only by owner or admin."
    end

    @scene.destroy
    redirect_to scenes_path, notice: "Scene '#{@scene.title}' deleted."
  end

  protected

  def scene_fields
    params.require(:scene).permit(:title, :description)
  end

end
