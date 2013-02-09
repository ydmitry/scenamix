class Response < ActiveRecord::Base
  attr_accessible :scene_id, :response, :parent_id
  belongs_to :scene
  has_many :responses, foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Response'
  validates :response, presence: true

  def alternative
    Response.where("scene_id = ? AND parent_id = ? AND id != ?", self.scene_id, self.parent_id, self.id)
  end

  def ancestors
    [self.parent, self.parent.try(:ancestors)].compact.flatten
  end

  def descendants
    self.responses.map(&:descendants).flatten
  end

  def best_descendants
    response = Response.best_child_by_parent_id(self.scene_id, self.id)
    [response, response.try(:best_descendants)].compact.flatten
  end

  def self.best_child_by_parent_id(scene_id, parent_id)
    Response.where('scene_id = ?', scene_id).where('parent_id = ?', parent_id).order('upvotes - downvotes DESC').first
  end

  def best_scenario
    self.ancestors + [self] + self.best_descendants
  end
end
