class User < ActiveRecord::Base
  has_many :channels, through: :subscriptions
  has_many :subscriptions

  validates_presence_of :first_name, :last_name, :email, :hashed_password
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create

  def password
  @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    if new_password != ""
      @password = BCrypt::Password.create(new_password)
      self.hashed_password = @password
    end
  end

  def authenticate(user_input)
    self.password == user_input
  end

  def total_monthly_bill
    self.channels.pluck(:price_per_month).sum.round(2)  #replace with more efficient AR methods
    # self.channels.reduce(0) { |total, channel| total + channel.price_per_month.to_int }
  end

end
