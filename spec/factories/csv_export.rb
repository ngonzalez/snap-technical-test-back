FactoryBot.define do
  factory :csv_export do
    user
    format_name { 'csv' }
    file_name { Faker::File.file_name }
    file_uid { Faker::Number.number }
  end
end
