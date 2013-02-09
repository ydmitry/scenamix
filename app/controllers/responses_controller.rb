class ResponsesController < ApplicationController
  def create
    scene = Scene.find(params[:scene_id])
    @response = scene.responses.new(params[:response])

    if @response.save
      redirect_to scene, notice: "Response to #{scene.title} was successfully posted."
    else
      render :edit
    end
  end

  def show
    @response = Response.find(params[:id])
    respond_to do |format|
      format.json { render :json => @response.best_scenario }
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

  def alternative
    @response = Response.find(params[:id])

    respond_to do |format|
      format.json { render :json => @response.alternative }
    end
  end
  
  def post_alternative
    response = Response.find(params[:id])

    alternative_response = response.scene.responses.new do |alternative|
      alternative.parent_id = response.parent_id
      alternative.response = params[:response]
    end

    respond_to do |format|
      if alternative_response.save
        format.json { render json: alternative_response }
      else
        format.json { render json: { ok: 0 } }
      end
    end
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
