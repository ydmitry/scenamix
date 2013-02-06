class Scene < ActiveRecord::Base
  attr_accessible :title, :description
  has_many :responses, :dependent => :destroy
  validates :title, :description, presence: true

  def best_scenario
   Response.where('scene_id = ?', self.id).select('id, scene_id, parent_id, response, upvotes, downvotes, MAX(upvotes - downvotes) as votes').group(:parent_id)
  end
end
