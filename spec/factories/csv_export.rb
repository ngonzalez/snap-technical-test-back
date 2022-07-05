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
FactoryBot.define do
  factory :csv_export do
    user
    format_name { 'csv' }
    file_name { Faker::File.file_name }
    file_uid { Faker::Number.number }
    file { Tempfile.new }
  end
end
