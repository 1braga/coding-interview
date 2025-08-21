class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  belongs_to :company

  scope :by_company, -> (identifier) {
    where(company_id: identifier) if identifier.present?
  }

  scope :by_username, -> (username) {
    where('username ILIKE?', "%#{username}%") if username.present?
  }

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
