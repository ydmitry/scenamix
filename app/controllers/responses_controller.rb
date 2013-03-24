class ResponsesController < ApplicationController
  def create
    scene = Scene.find(params[:scene_id])

    @response = scene.responses.new do |response|
      response.scene_id = params[:scene_id]
      response.parent_id = params[:response][:parent_id]
      response.response = params[:response][:response]
      response.user_id = current_user.try(:id) ? current_user.id : 0
      response.ip_address = request.remote_ip
    end

    respond_to do |format|
      if @response.save
        format.html { redirect_to scene, notice: "Response to #{scene.title} was successfully posted." }
        format.json { render :json => @response, :root => false }
      else
        format.html { render :edit }
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

    if @response.update_attributes(params[:response])
      redirect_to @response.scene, notice: "#Response was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    response = Response.find(params[:id])
    response.destroy
    redirect_to response.scene, notice: "Response deleted."
  end

  def upvote
    response = Response.find(params[:id])

    response.increment! :upvotes

    respond_to do |format|
      format.json { render json: { upvotes: response.upvotes, downvotes: response.downvotes } }
    end
  end

  def downvote
    response = Response.find(params[:id])

    response.increment! :downvotes

    respond_to do |format|
      format.json { render json: { upvotes: response.upvotes, downvotes: response.downvotes } }
    end
  end
end
