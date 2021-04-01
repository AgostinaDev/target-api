# == Schema Information
#
# Table name: topics
#
#  id          :bigint           not null, primary key
#  description :string(50)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Topic < ApplicationRecord
  validates :description, presence: true, uniqueness: true, length: { maximum: 50 }

  has_one_attached :image
end
