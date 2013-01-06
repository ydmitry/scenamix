class Scene < ActiveRecord::Base
  attr_accessible :title, :description
  has_many :scenes, :dependent => :destroy
end
