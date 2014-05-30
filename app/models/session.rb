class Session < ActiveRecord::Base
  belongs_to :user
  has_one :key

  validates :container_host, presence: true
  validates :container_port, presence: true
  validates :container_hashid, presence: true
end
