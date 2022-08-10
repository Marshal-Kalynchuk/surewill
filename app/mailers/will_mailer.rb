class WillMailer < ApplicationMailer

  def will_accessor_released_email(will, accessor)
    @will = will
    @url = user_will_url(@will.user, @will)
    @accessor = accessor
    mail(to: email_address_with_name(accessor.email, accessor.name), subject: "Will release notice")
  end

  def will_testator_released_email(will)
    @will = will
    mail(to: email_address_with_name(will.user.email, will.testator), subject: "Will release notice")
  end

  def added_to_will_email(will, accessor)
    @will = will
    @accessor = accessor
    @url = user_will_url(@will.user, @will)

    unless User.find_by(email: accessor.email) 
      user = User.invite!(email: accessor.email, skip_invitation: true) 
      @raw_invitation_token = user.raw_invitation_token
      user.invitation_sent_at = Time.current
    end

    mail(to: email_address_with_name(accessor.email, accessor.name), subject: "Added to #{will.testator}'s will")
  end

  def releaser_status_email(will, accessor)
    @will = will
    @accessor = accessor
    @url = user_will_url(@will.user, @will)
    mail(to: email_address_with_name(accessor.email, accessor.name), subject: "Releaser status change")
  end

end
