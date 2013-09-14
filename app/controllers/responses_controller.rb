class ResponsesController < ApplicationController
  def new
    @scene = Scene.find(params[:scene_id])
    @response = @scene.responses.new
  end

  def create
    scene = Scene.find(params[:scene_id])

    @response = scene.responses.new(response_fields)
    @response.user = current_user
    @response.ip_address = request.remote_ip

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

    if @response.update_attributes(response_fields)
      redirect_to [@response.scene, @response], notice: "#Response was successfully updated."
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

  protected

  def response_fields
    params.require(:response).permit(:scene_id, :response, :parent_id)
  end

end
