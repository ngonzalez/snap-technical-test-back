require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe CsvExportWorker, type: :worker do
  let!(:user) { FactoryBot.create(:user_with_shifts) }
  let(:csv_export) { FactoryBot.create(:csv_export) }
  describe 'testing worker' do
    it 'jobs are enqueued in the default queue' do
      described_class.perform_async csv_export.id
      assert_equal :default, described_class.queue
    end
    it 'goes into the jobs array for testing environment' do
      expect do
        described_class.perform_async csv_export.id
      end.to change(described_class.jobs, :size).by(1)
    end
    context 'csv export has no file_uid' do
      setup do
        csv_export.file_uid = nil
      end
      context 'a worker starts' do
        setup do
          described_class.new.perform csv_export.id
        end
        it 'sets csv export file_uid' do
          expect(csv_export.reload.file_uid).not_to be_nil
        end
      end
    end
    context 'csv export has no file_name' do
      setup do
        csv_export.file_name = nil
      end
      context 'a worker starts' do
        setup do
          described_class.new.perform csv_export.id
        end
        it 'sets csv export file_name' do
          expect(csv_export.reload.file_name).not_to be_nil
        end
      end
    end
  end
end