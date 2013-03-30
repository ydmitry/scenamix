class Response < ActiveRecord::Base
  attr_accessible :scene_id, :response, :parent_id, :user_id, :ip_address
  belongs_to :scene
  belongs_to :user
  has_many :responses, foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Response'
  validates :response, presence: true

  def user_name
    if self.user.present?
      'User' + self.user.id
    else
      'Guest'
    end
  end

  def votes
    self.upvotes - self.downvotes
  end

  def alternative
    Response.where("scene_id = ? AND parent_id = ? AND id != ?", self.scene_id, self.parent_id, self.id)
  end

  def alternative_size
    self.alternative.size
  end

  def sequels
    Response.where("scene_id = ? AND parent_id = ?", self.scene_id, self.id)
  end

  def best_scenario
    self.ancestors + [self] + self.best_descendants
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

  def self.best_child_by_parent_id(scene_id, parent_id)
    Response.best_children_by_parent_id(scene_id, parent_id).first
  end

  def self.best_children_by_parent_id(scene_id, parent_id)
    Response.where('scene_id = ?', scene_id).where('parent_id = ?', parent_id).order('upvotes - downvotes DESC')
  end

  private

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
