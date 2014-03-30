class User < ActiveRecord::Base
  devise :yubikey_database_authenticatable, :trackable, :timeoutable

  attr_accessor :yubiotp

  def registeredyubikey=(yubiotp)
    write_attribute(:registeredyubikey, yubiotp[0..11])
  end

end
