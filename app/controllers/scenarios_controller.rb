class ScenariosController < ApplicationController
  def next
    scene = Scene.find(params[:scene_id])
    response = Response.find(params[:id])

    id = response.best_scenario_last_id

    scenarios_response_ids = scene.scenarios_response_ids
    
    idx = (scenarios_response_ids.index(id.to_i) + 1) % scenarios_response_ids.size

    next_id = scenarios_response_ids[idx]

    response_next = Response.find(next_id)

    @scenario = response_next.best_scenario
    respond_to do |format|
      format.html { redirect_to scene_response_path(scene, response_next)}
      format.json { render :json => @scenario, :root => false }
    end
  end

  def prev
    scene = Scene.find(params[:scene_id])
    response = Response.find(params[:id])

    id = response.best_scenario_last_id

    scenarios_response_ids = scene.scenarios_response_ids
    
    idx = (scenarios_response_ids.index(id.to_i) - 1) % scenarios_response_ids.size

    prev_id = scenarios_response_ids[idx]

    response_prev = Response.find(prev_id)

    @scenario = response_prev.best_scenario
    respond_to do |format|
      format.html { redirect_to scene_response_path(scene, response_prev)}
      format.json { render :json => @scenario, :root => false }
    end
  end
end
