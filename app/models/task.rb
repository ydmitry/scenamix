class Task < ActiveRecord::Base
  belongs_to :response
  belongs_to :role
  belongs_to :scene
end
