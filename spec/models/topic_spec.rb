# == Schema Information
#
# Table name: topics
#
#  id          :bigint           not null, primary key
#  description :string(50)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Topic, type: :model do
  context 'Validations' do
    subject { build(:topic) }

    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_uniqueness_of(:description) }
    it { is_expected.to validate_length_of(:description) }
  end
end
