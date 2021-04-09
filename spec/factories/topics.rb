# == Schema Information
#
# Table name: topics
#
#  id          :bigint           not null, primary key
#  description :string(50)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :topic do
    description { Faker::Lorem.sentence }

    trait :with_image do
      image { Rack::Test::UploadedFile.new('spec/support/assets/test-image.png', 'image/png') }
    end
  end
end
