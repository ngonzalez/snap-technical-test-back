# == Schema Information
#
# Table name: csv_exports
#
#  id          :bigint           not null, primary key
#  file_name   :string
#  file_uid    :string
#  format_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_csv_exports_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe CsvExport, type: :model do
  it { is_expected.to validate_presence_of(:format_name) }
  it { is_expected.to validate_presence_of(:user_id) }

  describe "creation" do
    let(:csv_export) { FactoryBot.create(:csv_export) }
    it "can be created" do
      expect(csv_export).to be_valid
    end
  end

  describe "validations" do
    let(:csv_export) { FactoryBot.build(:csv_export) }
    it "should have a format name" do
      csv_export.format_name = nil
      expect(csv_export).to_not be_valid
      expect(csv_export.errors.full_messages.include?("Format name is not included in the list")).to eq(true)
    end
    it "should have a valid format name" do
      csv_export.format_name = "test"
      expect(csv_export).to_not be_valid
      expect(csv_export.errors.full_messages.include?("Format name is not included in the list")).to eq(true)
    end
    it "should have a user" do
      csv_export.user_id = nil
      expect(csv_export).to_not be_valid
      expect(csv_export.errors.full_messages.include?("User can't be blank")).to eq(true)
    end
  end
end
