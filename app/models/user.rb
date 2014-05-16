class User < ActiveRecord::Base
  devise :yubikey_database_authenticatable, :trackable, :timeoutable

  attr_accessor :yubiotp

  has_many :keys

  def registeredyubikey=(yubiotp)
    write_attribute(:registeredyubikey, yubiotp[0..11])
  end

end
