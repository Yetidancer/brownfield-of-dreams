# frozen_string_literal: true

# This is a class
class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :position
end
