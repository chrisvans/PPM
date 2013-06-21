class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name, :bio
  after_initialize :set_attr
  
  attr_accessor :password
  attr_accessor :name
  attr_accessor :bio

  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  #has_attached_file :photo, :styles => { :small => "150x150>" },
                    #:url  => "/assets/products/:id/:style/:basename.:extension",
                    #:path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  #validates_attachment_presence :photo
  #validates_attachment_size :photo, :less_than => 5.megabytes
  #validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  
  def set_attr
    @name = ''
    @bio = ''
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