class EmailInvitation
  attr_reader :name,
              :email,
              :sender_name

  def initialize(sender_name, recp_args)
    @sender_name = sender_name
    @name = recp_args[:name]
    @email = recp_args[:email]
  end
end
