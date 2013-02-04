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
    scene = Scene.find(response.scene_id)

    @alternative_response = scene.responses.new({
      :parent_id => response.parent_id,
      :response => params[:response]
    })

    if @alternative_response.save
      respond_to do |format|
        format.json { render :json => {:ok => 1} }
      end
    else
      respond_to do |format|
        format.json { render :json => {:ok => 0} }
      end
    end
  end

  def weightup
    response = Response.find(params[:id])

    weight = response.weightup
    
    respond_to do |format|
      format.json { render :json => {:weight => weight} }
    end
  end

  def weightdown
    response = Response.find(params[:id])

    weight = response.weightdown
    
    respond_to do |format|
      format.json { render :json => {:weight => weight} }
    end
  end

end
