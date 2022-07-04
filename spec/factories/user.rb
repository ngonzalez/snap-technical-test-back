# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  authentication_token            :text
#  authentication_token_created_at :datetime
#  email                           :string           default(""), not null
#  encrypted_password              :string           default(""), not null
#  remember_created_at             :datetime
#  reset_password_sent_at          :datetime
#  reset_password_token            :string
#  role                            :enum             default("user"), not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }

    factory :user_with_shifts do
      transient do
        count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:shift, evaluator.count, user: user)
      end
    end

    factory :user_with_csv_exports do
      transient do
        count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:csv_export, evaluator.count, user: user)
      end
    end
  end
end
