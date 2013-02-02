class Response < ActiveRecord::Base
  attr_accessible :scene_id, :response, :parent_id
  belongs_to :scene
  has_many :next, :foreign_key => "parent_id", :class_name => "Response"
  belongs_to :previous, :foreign_key => "parent_id", :class_name => "Response"
  validates :response, presence: true

  def alternative
    Response.where("parent_id = ? AND id != ?", self.previous.id.to_i, self.id)
  end
end
