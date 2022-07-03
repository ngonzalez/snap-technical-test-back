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
end
