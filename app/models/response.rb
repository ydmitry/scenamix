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

  def best_scenario
    prev_scenario = self.ancestors
    descendands_ids = self.descendants.map {|r| r.id }
    next_best_scenario = Response.where('scene_id = ?', self.scene_id).where('id IN(?)', descendands_ids).where('id = (SELECT id FROM responses AS r WHERE r.parent_id = responses.parent_id  ORDER BY upvotes - downvotes DESC LIMIT 1)').order('id ASC')
    prev_scenario + [self] + next_best_scenario
  end
end
