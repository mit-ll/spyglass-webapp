class User < ActiveRecord::Base
  devise :yubikey_database_authenticatable, :trackable, :timeoutable

  attr_accessor :yubiotp

  has_many :keys
  has_many :sessions
  before_create :set_role
  before_save :ensure_user

  include RoleModel
  roles_attribute :roles_mask
  roles :user, :admin
  def set_role 
    if roles_mask == nil
      self.roles << [:user]
    end
  end

  def ensure_user
    self.roles << [:user]
  end

  def registeredyubikey=(yubiotp)
    write_attribute(:registeredyubikey, yubiotp[0..11])
  end

end
