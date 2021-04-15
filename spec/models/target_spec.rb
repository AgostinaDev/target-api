# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  latitude   :decimal(10, 6)   not null
#  longitude  :decimal(10, 6)   not null
#  radius     :integer          not null
#  title      :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Target, type: :model do
  context 'Validations' do
    subject { build(:target) }

    it { is_expected.to validate_presence_of(:radius) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title) }
    it { is_expected.to validate_numericality_of(:radius).is_greater_than_or_equal_to(50).is_less_than_or_equal_to(500) }
    it { is_expected.to validate_numericality_of(:latitude).is_greater_than_or_equal_to(-90).is_less_than_or_equal_to(90) }
    it { is_expected.to validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180).is_less_than_or_equal_to(180) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:topic) }
  end
end
