class Scene < ActiveRecord::Base
  attr_accessible :title, :description, :user_id, :ip_address
  has_many :responses, :dependent => :destroy
  belongs_to :user
  validates :title, :description, presence: true

  def best_scenario
    best_first_response = Response.best_child_by_parent_id(self.id, 0)
    if best_first_response then
      best_first_response.best_scenario
    else
      []
    end
  end

  def scenarios_response_ids
    best_first_responses = Response.best_children_by_parent_id(self.id, 0)
    best_first_responses.map(&:scenarios_response_ids).flatten
  end
end
