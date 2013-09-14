class Response < ActiveRecord::Base

  belongs_to :scene
  belongs_to :user
  belongs_to :parent, class_name: 'Response'
  has_many :responses, foreign_key: 'parent_id'
  
  validates :response, presence: true

  delegate :name, :to => :user, :allow_nil => true, :prefix => true

  after_create :update_scene_last_response

  def votes
    self.upvotes - self.downvotes
  end

  def alternative
    Response.where("scene_id = ? AND parent_id = ? AND id != ?", self.scene_id, self.parent_id, self.id)
  end

  def alternative_size
    self.alternative.size
  end

  def responses_size
    self.responses.size
  end

  def best_scenario
    ancestors + [self] + best_descendants
  end

  def best_scenario_last_id
    self.best_scenario.last.id
  end

  def scenarios_response_ids
    stack = [self]
    result = []
    while stack.present?
      response = stack.shift
      best_children = Response.best_children_by_parent_id(response.scene_id, response.id)
      if best_children.empty?
        result.push response.id
      else
        stack = best_children + stack
      end
    end
    
    result
  end

  def scenarios_next?
    id = self.best_scenario_last_id

    scenarios_response_ids = self.scene.scenarios_response_ids

    scenarios_response_ids.index(id.to_i) + 1 > scenarios_response_ids.size - 1
  end

  def scenarios_next_id
    id = self.best_scenario_last_id

    scenarios_response_ids = self.scene.scenarios_response_ids

    idx = (scenarios_response_ids.index(id.to_i) + 1) % scenarios_response_ids.size

    scenarios_response_ids[idx]
  end

  def scenarios_prev?
    id = self.best_scenario_last_id

    scenarios_response_ids = self.scene.scenarios_response_ids

    scenarios_response_ids.index(id.to_i) - 1 < 0
  end

  def scenarios_prev_id
    id = self.best_scenario_last_id

    scenarios_response_ids = self.scene.scenarios_response_ids

    idx = (scenarios_response_ids.index(id.to_i) - 1) % scenarios_response_ids.size

    scenarios_response_ids[idx]
  end

  def self.best_child_by_parent_id(scene_id, parent_id)
    Response.best_children_by_parent_id(scene_id, parent_id).first
  end

  def self.best_children_by_parent_id(scene_id, parent_id)
    Response.where('scene_id = ?', scene_id).where('parent_id = ?', parent_id).order('upvotes - downvotes DESC')
  end

  private

  def update_scene_last_response
    self.scene.update_attribute(:last_response_at, self.created_at)
  end

  def ancestors
    [self.parent.try(:ancestors), self.parent].compact.flatten
  end

  def descendants
    self.responses.map(&:descendants).flatten
  end

  def best_descendants
    response = Response.best_child_by_parent_id(self.scene_id, self.id)
    [response, response.try(:best_descendants)].compact.flatten
  end

end
