class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email, { presence: true, uniqueness: { case_sensitive: false } }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true, length: { minimum: 5 }

  before_save do
    self.email.downcase! if self.email
    self.email.strip! if self.email
  end

  def self.authenticate_with_credentials(email, password)
    email2 = email.downcase.strip
    user = User.find_by_email(email2)
    if user
      user.authenticate(password)
    else
      nil
    end
  end
  
end
