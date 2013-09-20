class Scene < ActiveRecord::Base

  has_many :responses, :dependent => :destroy
  belongs_to :user

  validates :title, :description, presence: true

  delegate :name, :to => :user, :allow_nil => true, :prefix => true

  scope :ordered, order("created_at DESC")
  scope :visible, where(:hidden => false)
  scope :user, lambda { |id| where(:user_id => id) }

  def best_scenario
    best_first_response = responses.best_child_by_parent_id(self.id, 0)
    if best_first_response then
      best_first_response.best_scenario
    else
      []
    end
  end

  def scenarios_response_ids
    best_first_responses = responses.best_children_by_parent_id(self.id, 0)
    best_first_responses.map(&:scenarios_response_ids).flatten
  end

  def self.find_user_scenes(id)
    visible.ordered.user(id)
  end
end
