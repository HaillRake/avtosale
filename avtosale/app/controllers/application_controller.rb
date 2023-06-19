# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale, :authenticate_user!

  def set_locale
    I18n.locale = locale_param || cookies_locale || I18n.default_locale
    locale_cookie_set(I18n.locale) if locale_param.present?
  end

  private

  def locale_param
    params[:lang]&.to_sym
  end

  def cookies_locale
    cookies[:lang]&.to_sym
  end

  def locale_cookie_set(locale)
    cookies[:lang] = { value: locale, expire: 1.year.from_now }
  end
end
