class AlternativeResponsesController < ApplicationController
  def show
    @response = Response.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @response, :root => false, :serializer => AlternativeResponsesSerializer }
    end
  end

  def create
    scene = Scene.find(params[:scene_id])
    response = Response.find(params[:id])
    alternative_response = scene.responses.new(params[:response])
    alternative_response.user = current_user
    alternative_response.ip_address = request.remote_ip
    alternative_response.parent_id = response.id

    respond_to do |format|
      if alternative_response.save
        format.json { render json: alternative_response }
      else
        format.json { render json: { ok: 0 } }
      end
    end
  end
end
