class Channel < ActiveRecord::Base
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  validates_presence_of :name, :callsign, :price_per_month

  def total_subscribers
    self.subscribers.length
  end

end
