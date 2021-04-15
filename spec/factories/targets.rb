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
FactoryBot.define do
  factory :target do
    title { Faker::Lorem.sentence }
    radius { Faker::Number.between(50, 500) }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
