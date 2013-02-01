class Response < ActiveRecord::Base
  attr_accessible :scene_id, :response
  belongs_to :scene
  has_many :next, :foreign_key => "parent_id", :class_name => "Scenario"
  belongs_to :previous, :class_name => "Scenario"
  validates :response, presence: true
end
