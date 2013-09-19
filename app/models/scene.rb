class Scene < ActiveRecord::Base

  has_many :responses, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  belongs_to :user

  validates :title, :description, presence: true

  delegate :name, :to => :user, :allow_nil => true, :prefix => true

  scope :ordered, -> { order("created_at DESC") }
  scope :visible, -> { where(:hidden => false) }

  def self.find_visible_scenes
    visible.ordered
  end
end
