class SceneSequelsSerializer < ActiveModel::Serializer
  include ERB::Util
  include ActionView::Helpers::TextHelper
  include ApplicationHelper

  attributes :id, :scene_id, :parent_id, :response, :votes, :sequels_size, :responses_size, :user_id, :user_name, :created_at
  has_many :responses

  def scene_id
  	object.id
  end

  def response
    post_format(object.description)
  end

  def created_at
    datetime_format(object.created_at)
  end

  def parent_id
  	0
  end

  def votes
  	0
  end

  def responses_size
  	object.sequels_size
  end

  def responses
    object.sequels
  end
end
