class Accessor < ApplicationRecord
  belongs_to :user
  belongs_to :will

  attr_accessor :email
  after_initialize :link_user, if: :new_record? 
  after_initialize :set_email, unless: :new_record? 

  private
  def set_email
    self.email = self.user.email
  end
  def link_user 
    self.user_id = (User.find_by(email: self.email) || User.invite!(email: self.email)).id
  end
  
end
