# == Schema Information
#
# Table name: shifts
#
#  id         :bigint           not null, primary key
#  end_at     :datetime         not null
#  start_at   :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_shifts_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Shift, type: :model do

  describe "creation" do
    let(:shift) { FactoryBot.create(:shift) }
    it "can be created" do
      expect(shift).to be_valid
    end
  end

  describe "validations" do
    let(:shift) { FactoryBot.build(:shift) }
    it "should have a start date" do
      shift.start_at = nil
      expect(shift).to_not be_valid
      expect(shift.errors.full_messages.include?("Start at can't be blank")).to eq(true)
    end
    it "should have a end date" do
      shift.end_at = nil
      expect(shift).to_not be_valid
      expect(shift.errors.full_messages.include?("End at can't be blank")).to eq(true)
    end
    it "should have a user" do
      shift.user = nil
      expect(shift).to_not be_valid
      expect(shift.errors.full_messages.include?("User can't be blank")).to eq(true)
    end
  end
end
