# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :searches_users, dependent: :delete_all
  has_many :searches, through: :searches_users

  validate :password_complexity, :email_complexity

  PASSWORD_REGEX = /^(?=.*[A-Z])(?=(?:.*[~@$!#%*^(){}_?&]){2})[a-zA-Z0-9~@$!#%*^(){}_?&]{8,20}$/
  EMAIL_REGEX = /^([a-zA-Z0-9+_.-]{5,})@([a-zA-Z0-9+_.-]+\.)+[a-zA-Z]{2,4}$/

  def password_complexity
    if password.blank? ||
       password =~ PASSWORD_REGEX
      return
    end

    errors.add :password, I18n.t('password_error')
  end

  def email_complexity
    return if email.blank? || email =~ EMAIL_REGEX

    errors.add :email, I18n.t('email_error')
  end
end
