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
FactoryBot.define do
  factory :shift do
    user
    start_at { 1.day.ago }
    end_at { 1.day.ago + 1.hour }
  end
end
