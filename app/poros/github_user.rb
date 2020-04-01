class GithubUser
  attr_reader :user_name,
              :profile_url,
              :email

  def initialize(args)
    @user_name   = args[:login]
    @profile_url = args[:html_url]
    @email       = args[:email]
  end
end
