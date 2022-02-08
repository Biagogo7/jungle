class User < ActiveRecord::Base
  has_secure_password  
  
  
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, uniqueness: { case_sensitive: false, message: 'User already registered' }, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  
  def self.authenticate_with_credentials (email, password)
    user = self.find_by_email(email)
      if user && user.authenticate(password)
        return user
      else 
        return nil
      end
  end

  def self.find_by_email (email)
    trimmed_email = email.gsub(/\s+/, '')
    User.where('lower(email) = ?', trimmed_email.downcase).first
  end


  

end
