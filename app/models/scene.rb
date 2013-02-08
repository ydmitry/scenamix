class Scene < ActiveRecord::Base
  attr_accessible :title, :description
  has_many :responses, :dependent => :destroy
  validates :title, :description, presence: true

  def best_scenario
    Response.where('scene_id = ?', self.id).where('id = (SELECT id FROM responses AS r WHERE r.parent_id = responses.parent_id  ORDER BY upvotes - downvotes DESC LIMIT 1)').order('id ASC')
  end

  def response_scenario(response)
    prev_scenario = response.ancestors
    best_subscenario = Response.where('scene_id = ?', self.id).where('parent_id >= ?', response.id).where('id = (SELECT id FROM responses AS r WHERE r.parent_id = responses.parent_id  ORDER BY upvotes - downvotes DESC LIMIT 1)').order('id ASC')
    prev_scenario + [response] + best_subscenario
  end
end
