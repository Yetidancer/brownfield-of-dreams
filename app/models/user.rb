class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def in_system(username)
    User.all.find {|user| user.github_username == username}
  end

  def github_id
    @github_id ||= GithubService.new.user_github_id(token)
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
end
