class EmailInvitation
  attr_reader :recipient,
              :email,
              :sender

  def initialize(sender_name, recipient)
    require "pry"; binding.pry
    # @email = recipient.email
    @email = 'clarkzeke@gmail.com'
    @recipient = recipient.name
    @sender = sender_name
  end
end
