class WillMailer < ApplicationMailer

  def will_beneficiary_released_email(will, beneficiary)
    @will = will
    @url = user_will_url(@will.user, @will)
    @beneficiary = beneficiary
    mail(to: email_address_with_name(beneficiary.email, beneficiary.name), subject: "Will release notice")
  end

  def will_testator_released_email(will)
    @will = will
    mail(to: email_address_with_name(will.user.email, will.testator), subject: "Will release notice")
  end

  def added_to_will_email(will, beneficiary)
    @will = will
    @beneficiary = beneficiary
    @url = user_will_url(@will.user, @will)

    unless User.find_by(email: beneficiary.email) 
      user = User.invite!(email: beneficiary.email, skip_invitation: true) 
      @raw_invitation_token = user.raw_invitation_token
      user.invitation_sent_at = Time.current
    end

    mail(to: email_address_with_name(beneficiary.email, beneficiary.name), subject: "Added to #{will.testator}'s will")
  end

  def releaser_status_email(will, beneficiary)
    @will = will
    @beneficiary = beneficiary
    @url = user_will_url(@will.user, @will)
    mail(to: email_address_with_name(beneficiary.email, beneficiary.name), subject: "Releaser status change")
  end

end
