class User < ActiveRecord::Base
  devise :yubikey_database_authenticatable, :rememberable, :trackable, 
         :timeoutable
  
  def registeredyubikey=(yubiotp)
    write_attribute(:registeredyubikey, yubiotp[0..11])
  end

end
