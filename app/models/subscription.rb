class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  validates_presence_of :user, :channel

  def validates_user_id
  errors.add(:user_id, "User does not exist") unless User.exists?(self.user_id)
  end

def validates_channel_id
  errors.add(:channel_id, "Channel does not exist") unless Channel.exists?(self.channel_id)
end

end
