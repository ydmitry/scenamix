class ResponseSerializer < ActiveModel::Serializer
  include ERB::Util
  include ActionView::Helpers::TextHelper
  include ApplicationHelper

  attributes :id, :scene_id, :parent_id, :response, :votes, :alternative_size, :user_name, :created_at

  def response
    post_format(object.response)
  end
end
