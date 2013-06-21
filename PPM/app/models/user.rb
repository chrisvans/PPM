class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name, :bio
  after_initialize :set_attr
  
  attr_accessor :password
  attr_accessor :name
  attr_accessor :bio
  attr_accessor :public_profile

  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def set_attr
    @name = ''
    @bio = ''
    @public_profile = ''
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end