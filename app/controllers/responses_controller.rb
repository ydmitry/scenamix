class ResponsesController < ApplicationController
  def new
    @scene = Scene.find(params[:scene_id])
    @response = @scene.responses.new
  end

  def create
    scene = Scene.find(params[:scene_id])
    params_response = params[:response]

    @response = scene.responses.new do |response|
      response.scene_id = scene.id
      response.parent_id = params_response[:parent_id]
      response.response = params_response[:response]
      response.user_id = current_user.try(:id)
      response.ip_address = request.remote_ip
    end

    respond_to do |format|
      if @response.save
        format.html { redirect_to scene, notice: "Response to #{scene.title} was successfully posted." }
        format.json { render :json => @response, :root => false }
      else
        format.html { render :new }
        format.json { render :json => false }
      end
    end
  end

  def show
    @scene = Scene.find(params[:scene_id])    
    @response = Response.find(params[:id])
    @scenario = @response.best_scenario
    respond_to do |format|
      format.html { render :template => "scenes/show" }
      format.json { render :json => @scenario, :root => false }
    end
  end

  def edit
    @response = Response.find(params[:id])
  end

  def update
    @response = Response.find(params[:id])

    if !current_user.try(:id)
      raise "Response can be edited only by user."
    end

    if !current_user.try(:admin?) && current_user.try(:id) != @response.user_id
      raise "Response can be edited only by owner or admin."
    end

    if @response.update_attributes(params[:response])
      redirect_to @response, notice: "#Response was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    response = Response.find(params[:id])

    if !current_user.try(:id)
      raise "Response can be deleted only by user."
    end

    if !current_user.try(:admin?) && current_user.try(:id) != @response.user_id
      raise "Response can be deleted only by owner or admin."
    end

    response.destroy
    redirect_to response.scene, notice: "Response deleted."

  end

  def upvote
    response = Response.find(params[:id])

    response.increment! :upvotes

    respond_to do |format|
      format.json { render json: { votes: response.votes } }
    end
  end

  def downvote
    response = Response.find(params[:id])

    response.increment! :downvotes

    respond_to do |format|
      format.json { render json: { votes: response.votes } }
    end
  end
end
