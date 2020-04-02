class GithubService

  def user_repos(token)
    get_json("user/repos", token).first(5)
  end

	def user_followers(token)
		get_json("user/followers", token)
	end

	def user_following(token)
		get_json("user/following", token)
	end

	def get_user(token, user_handle)
    # require "pry"; binding.pry
    get_json("users/#{user_handle}", token)
	end

  private

  def get_json(url, token)
    response = conn(token).get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn(token)
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers[:authorization] = "token #{token}"
    end
  end
end
