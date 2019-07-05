class User < ApplicationRecord
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
    length: {maximum: Settings.check_user.name_max_length}

  validates :email, presence: true,
    length: {maximum: Settings.check_user.mail_max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.check_user.pass_min_length}

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine.MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end

  private

  def downcase_email
    email.downcase!
  end
end
