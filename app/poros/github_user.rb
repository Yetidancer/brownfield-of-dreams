# frozen_string_literal: true

# This is a class
class GithubUser
  attr_reader :username,
              :profile_url,
              :email,
              :name

  def initialize(args)
    @name = args[:name]
    @username = args[:login]
    @profile_url = args[:html_url]
    @email = args[:email]
  end
end
