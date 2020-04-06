# frozen_string_literal: true

# This is a class
class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name, :last_name
  enum role: %i[default admin]
  has_secure_password

  def friends
    friendships =
    Friendship.all.find_all { |friendship| friendship.user_id == id }
    friends = friendships.map { |friendship| User.find(friendship.friend_id) }
    friends
  end

  def in_system(username)
    User.all.find { |user| user.github_username == username }
  end

  def repos
    @repos ||= GithubService.new.user_repos(token)
  end

  def followers
    @followers ||= GithubService.new.user_followers(token)
  end

  def following
    @following ||= GithubService.new.user_following(token)
  end

  def bookmarked_segments
    videos.joins(:tutorial).group('tutorials.id, videos.id').order('tutorials.id, videos.position')
  end

  def send_inform(email_info)
     NewUserNotifierMailer.inform(email_info).deliver_now
  end
end
