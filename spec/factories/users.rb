# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string(320)
#  encrypted_password :string           default(""), not null
#  first_name         :string(50)
#  gender             :enum             default("other"), not null
#  last_name          :string(50)
#  provider           :string           default("email"), not null
#  tokens             :json
#  uid                :string           default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email             (email) UNIQUE
#  index_users_on_uid_and_provider  (uid,provider) UNIQUE
#

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    gender { User.genders.values.sample }
  end
end
