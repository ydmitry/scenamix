class Scene < ActiveRecord::Base
  attr_accessible :title, :description
  has_many :responses, :dependent => :destroy
  validates :title, :description, presence: true

  def best_scenario
    best_first_response = Response.best_child_by_parent_id(self.id, 0)
    best_first_response.best_scenario
  end
end
