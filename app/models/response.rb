class Response < ActiveRecord::Base

  belongs_to :scene
  belongs_to :user
  belongs_to :parent, class_name: 'Response'
  has_many :responses, foreign_key: 'parent_id'

  validates :response, presence: true

  delegate :name, :to => :user, :allow_nil => true, :prefix => true

  after_create :update_scene_last_response

  private

  def update_scene_last_response
    self.scene.update_attribute(:last_response_at, self.created_at)
  end

  def ancestors
    [self.parent.try(:ancestors), self.parent].compact.flatten
  end

  def descendants
    self.responses.map(&:descendants).flatten
  end

end
