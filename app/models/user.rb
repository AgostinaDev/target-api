# frozen_string_literal: true

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
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum gender: { female: 'female', male: 'male', other: 'other' }

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :gender, presence: true
  has_many :targets, dependent: :destroy
end
