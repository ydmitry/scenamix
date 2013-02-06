class Response < ActiveRecord::Base
  attr_accessible :scene_id, :response, :parent_id
  belongs_to :scene
  has_many :responses, foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Response'
  validates :response, presence: true

  def alternative
    Response.where("scene_id = ? AND parent_id = ? AND id != ?", self.scene_id, self.parent_id, self.id)
  end
end
