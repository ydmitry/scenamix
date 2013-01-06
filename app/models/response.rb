class Response < ActiveRecord::Base
  attr_accessible :scene_id, :response
  belongs_to :scene
end
