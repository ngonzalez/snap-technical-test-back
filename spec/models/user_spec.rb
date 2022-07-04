# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :enum             default("user"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "creation" do
    let!(:user) { FactoryBot.create(:user) }

    it "can be created" do
      expect(user).to be_valid
    end

    it 'validates email' do
      expect(user.valid?).to eq(true)
    end
    context 'it has no email' do
      setup do
        user.email = nil
      end
      it 'is not valid' do
        expect(user.valid?).to eq(false)
        expect(user.errors.full_messages).to eq(["Email can't be blank", "Email is invalid"])
      end
    end
    context 'it has an invalid email' do
      setup do
        user.email = "test"
      end
      it 'is not valid' do
        expect(user.valid?).to eq(false)
        expect(user.errors.full_messages).to eq(["Email is invalid"])
      end
    end
    context 'a valid email' do
      setup do
        user.email = "test@example.com"
      end
      it 'is not valid' do
        expect(user.valid?).to eq(true)
        expect(user.errors.full_messages).to eq([])
      end
    end
  end
end
