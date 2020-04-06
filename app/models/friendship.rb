# frozen_string_literal: true

# This is a class
class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
