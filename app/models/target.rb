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
class Target < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :title, presence: true, length: { maximum: 50 }
  validates :radius, presence: true,
                     numericality: { greater_than_or_equal_to: 50, less_than_or_equal_to: 500 }
  validates :latitude, presence: true,
                       numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true,
                        numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
end
