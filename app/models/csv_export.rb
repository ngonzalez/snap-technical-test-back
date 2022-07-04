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
class CsvExport < ActiveRecord::Base
  belongs_to :user

  dragonfly_accessor :file

  validates :format_name, inclusion: { in: %w(csv xls) }
end
