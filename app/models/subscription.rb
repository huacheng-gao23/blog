class Subscription < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, presence: true

  enum status: { pending: "pending", active: "active", unsubscribed: "unsubscribed" }

  before_create :set_subscribed_at

  private

  def set_subscribed_at
    self.subscribed_at = Time.current
  end
end
