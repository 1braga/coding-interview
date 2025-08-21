class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  belongs_to :company

  validates :display_name, presence: true
  validates :username, presence: true
  validates :email, presence: true

  scope :by_company, -> (identifier) {
    where(company_id: company_id) if identifier.present?
  }

  scope :by_username, -> (username) {
    where('username ILIKE ?', "%#{username}%") if username.present?
  }

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
