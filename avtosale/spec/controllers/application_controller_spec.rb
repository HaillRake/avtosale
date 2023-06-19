# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def index
      locale_param
      locale_cookie_set(params[:lang])
    end
  end

  describe '#set_locale' do
    context 'when locale is set in params' do
      before { get :index, params: { lang: 'uk' } }

      it 'sets the locale to the specified value' do
        expect(I18n.locale).to eq(:uk)
      end
    end
  end
end
