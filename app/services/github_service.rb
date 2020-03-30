class GithubService
  def user_github_id(token)
    get_json("user", token)[:id]
  end

  def user_repos(token)
    get_json("user/repos", token).first(5)
  end

	def user_followers(token)
		get_json("user/followers", token)
	end

	def user_following(token)
		get_json("user/following", token)
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
