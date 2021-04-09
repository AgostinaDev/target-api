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
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:gender) }
    it { is_expected.to validate_length_of(:first_name) }
    it { is_expected.to validate_length_of(:last_name) }
  end

  context 'Gender enum definition' do
    subject { build(:user) }

    it {
      is_expected.to define_enum_for(:gender).with_values(female: 'female', male: 'male',
                                                          other: 'other').backed_by_column_of_type(:enum)
    }
    it { is_expected.to allow_values(:female, :male, :other).for(:gender) }
  end
end
