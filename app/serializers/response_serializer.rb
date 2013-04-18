class ResponseSerializer < ActiveModel::Serializer
  include ERB::Util
  include ActionView::Helpers::TextHelper
  include ApplicationHelper

  attributes :id, :scene_id, :parent_id, :response, :votes, :alternative_size, :user_id, :user_name, :created_at, :responses_size

  def response
    post_format(object.response)
  end

  def created_at
    datetime_format(object.created_at)
  end

end
