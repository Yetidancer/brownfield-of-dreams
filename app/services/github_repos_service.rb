class GithubReposService
  def user_info(token)
    get_json("user/repos", token).first(5)
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
