class ScenariosController < ApplicationController
  def next
    scene = Scene.find(params[:scene_id])
    response = Response.find(params[:id])

    response_next = Response.find(response.scenarios_next_id)

    @scenario = response_next.best_scenario
    respond_to do |format|
      format.html { redirect_to scene_response_path(scene, response_next)}
      format.json { render :json => @scenario, :root => false }
    end
  end

  def prev
    scene = Scene.find(params[:scene_id])
    response = Response.find(params[:id])

    response_prev = Response.find(response.scenarios_prev_id)

    @scenario = response_prev.best_scenario
    respond_to do |format|
      format.html { redirect_to scene_response_path(scene, response_prev)}
      format.json { render :json => @scenario, :root => false }
    end
  end
end
