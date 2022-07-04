require 'rails_helper'

RSpec.describe CsvExport, type: :model do
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
    it "should have a user" do
      csv_export.user_id = nil
      expect(csv_export).to_not be_valid
      expect(csv_export.errors.full_messages.include?("User can't be blank")).to eq(true)
    end
  end
end
