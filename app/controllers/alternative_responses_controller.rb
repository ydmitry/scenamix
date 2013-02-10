class AlternativeResponsesController < ApplicationController
  def show
    @response = Response.find(params[:id])

    respond_to do |format|
      format.json { render :json => @response.alternative }
    end
  end

  def create
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
end