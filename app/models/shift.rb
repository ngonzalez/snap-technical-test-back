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
class Shift < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :user

  validates :start_at, presence: true, allow_blank: false
  validates :end_at, presence: true, allow_blank: false
  validates :end_at, comparison: { greater_than: :start_at }

  def self.to_csv(col_sep: CSV::DEFAULT_OPTIONS.fetch(:col_sep))
    CSV.generate(col_sep: col_sep) do |csv|
      csv << column_names
      find_each do |shift|
        csv << shift.attributes.values_at(*column_names)
      end
    end
  end
end
