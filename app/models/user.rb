# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  session_token   :string(255)
#  password_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  
  extend FriendlyId
  friendly_id :username

  VALID_EMAIL_REGEX = Regexp.new(/\A[\w\d\.-]+@(?:\w+\.)+[\w]{2,}\Z/i)
  VALID_USERNAME_REGEX = Regexp.new(/\A\w+[\d\w\-\_]*\Z/i)

  attr_accessible :username, :password_digest,:password, :first_name, :last_name, :email

  attr_accessor :password

  validates :email, :format => { :with => VALID_EMAIL_REGEX }
  validates :username, :format => { :with => VALID_USERNAME_REGEX }

  validates :email, :username,
            :presence => true,
            :uniqueness => { :case_sensitive => false }
            # :on => :create,
            # :on => :update
  
  validates :password_digest, :presence => true

  validates :password,
            :presence => true,
            :length => { :minimum => 6 }
            # :on => :create,

  before_validation :ensure_session_token!

  def self.find_by_credentials(login, password)              
  	user = User.where(":login = lower(username) OR :login = lower(email)", :login => login.downcase);
  	return nil unless user
  	is_password?(user.password_digest, password) ? user : nil
  end

  def password=(plain_text)
    @password = plain_text
  	self.password_digest = BCrypt::Password.create(plain_text)
  end

  def reset_session_token!
  	self.session_token = SecureRandom.urlsafe_base64
  end

  def ensure_session_token!
    unless self.session_token
      self.reset_session_token!
    end
  end

  def self.search(keywords)
    User.where("lower(username) like ? OR lower(first_name) like ? OR \
              lower(last_name) like ?", *(["%#{keywords.downcase}%"] * 3)) || []
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
