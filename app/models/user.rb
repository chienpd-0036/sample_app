class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
    length: {maximum: Setting.check_user.name_max_length}

  validates :email, presence: true,
    length: {maximum: Setting.check_user.mail_max_length},
    format: {with: Setting.check_user.validate_email_regex},
    uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true,
    length: {minimum: Setting.check_user.pass_min_length}

  private

  def downcase_email
    email.downcase!
  end
end
