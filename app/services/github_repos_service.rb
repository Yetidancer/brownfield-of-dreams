class GithubReposService
  def user_info
    get_json("user/repos")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers[:authorization] = "#{ENV['GITHUB_API_KEY']}"
    end
  end
end
