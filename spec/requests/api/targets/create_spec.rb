require 'rails_helper'

RSpec.describe 'POST /api/v1/targets', type: :request do
  let(:title) { Faker::Lorem.sentence }
  let(:radius) { Faker::Number.between(from: 50, to: 500) }
  let(:latitude) { Faker::Address.latitude }
  let(:longitude) { Faker::Address.longitude }
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:target) { Target.last }

  let(:params) do
    {
      target: {
        title: title,
        radius: radius,
        latitude: latitude,
        longitude: longitude,
        topic_id: topic.id
      }
    }
  end

  subject(:create_target) do
    post api_v1_targets_path, params: params, headers: auth_headers, as: :json
  end

  context 'using valid authentication data' do
    it 'returns success' do
      create_target
      expect(response).to be_successful
    end

    it 'returns target data' do
      create_target
      expect(json).to include_json(
        target: {
          id: target.id,
          title: target.title,
          radius: target.radius,
          latitude: target.latitude.to_s,
          longitude: target.longitude.to_s,
          user_id: user.id,
          topic: {
            id: topic.id,
            description: topic.description
          }
        }
      )
    end

    it 'adds new target' do
      expect { create_target }.to change { Target.count }.by(1)
    end
  end

  context 'using invalid authentication data' do
    it 'returns unauthorized response' do
      post api_v1_targets_path, params: params, headers: {}, as: :json
      expect(response).to be_unauthorized
    end
  end
end
