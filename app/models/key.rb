class Key < ActiveRecord::Base

  before_save :hash_key
  
  belongs_to :user  

  validate :key_must_be_sshkey

  validates :keyname, presence: true
  validates :sshkey,  presence: true

  def hash_key
    self.sha1hash = SSHKey.sha1_fingerprint(self.sshkey)
  end

  def key_must_be_sshkey
    if SSHKey.valid_ssh_public_key?(self.sshkey) == false
      errors.add(:sshkey, "must be valid")
    end
  end
end
