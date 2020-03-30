class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

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
