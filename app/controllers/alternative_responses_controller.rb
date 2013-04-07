class AlternativeResponsesController < ApplicationController
  def show
    @scene = Scene.find(params[:scene_id])
    @response = Response.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @response.alternative, :root => false }
    end
  end

  def create
    response = Response.find(params[:id])
    params_response = params[:response]
    alternative_response = response.scene.responses.new do |alternative|
      alternative.parent_id = response.parent_id
      alternative.response = params_response[:response]
      alternative.user_id = current_user.try(:id)
      alternative.ip_address = request.remote_ip
    end

    respond_to do |format|
      if alternative_response.save
        format.json { render json: alternative_response }
      else
        format.json { render json: { ok: 0 } }
      end
    end
  end
end
