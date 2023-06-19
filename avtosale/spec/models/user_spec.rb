# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_many(:searches_users).dependent(:delete_all) }
    it { is_expected.to have_many(:searches).through(:searches_users) }
  end

  describe '#password_complexity' do
    context 'with a valid password' do
      let(:user) { build(:user, password: 'ValidPassword123!%') }

      it 'does not add an error to the password' do
        user.valid?
        expect(user.errors[:password]).to be_empty
      end
    end

    context 'with an invalid password' do
      let(:user) { build(:user, password: 'invalid') }

      it 'adds an error to the password' do
        user.valid?
        message = '(8 - 20 symbols) have to include 1 capital letter, 2 special characters'
        expect(user.errors[:password]).to include(message)
      end
    end
  end

  describe '#email_complexity' do
    context 'with a valid email' do
      let(:user) { build(:user, email: 'Valid@email.com') }

      it 'does not add an error to the email' do
        user.valid?
        expect(user.errors[:email]).to be_empty
      end
    end

    context 'with an invalid email' do
      let(:user) { build(:user, email: 'invalid') }

      it 'adds an error to the email' do
        user.valid?
        expect(user.errors[:email]).to include('Please, enter email-type format and at least 5 symbols before @')
      end
    end
  end
end
