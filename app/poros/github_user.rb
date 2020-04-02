class GithubUser
  attr_reader :user_name,
              :profile_url,
              :email,
              :name

  def initialize(args)
    @name = args[:name]
    @username   = args[:login]
    @profile_url = args[:html_url]
    @email       = args[:email]
  end
end
