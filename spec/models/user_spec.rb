require 'rails_helper'

RSpec.describe User, type: :model do
  # Define User to be used in tests
  let (:user) do
    user = User.new(
      email: 'someone@example.com',
      password: 'some_password_to_test'
    )
    user.save
    user
  end

  context 'validation test' do
    it 'ensures email presence' do
      user = User.new(password: 'some_password_to_test').save
      expect(user).to eq(false)
    end

    it 'ensures password presence' do
      user = User.new(email: 'someone@example.com').save
      expect(user).to eq(false)
    end

    it 'ensures user can be modified' do
      expect(user.update!(name: 'Someone')).to eq(true)
    end
  end
end
