require 'rails_helper'

RSpec.describe 'GET Topics', type: :request do
  shared_examples 'success response' do
    it 'returns a successful response' do
      get_topics
      expect(response).to be_successful
    end
  end

  subject(:get_topics) { get api_v1_topics_path, as: :json }

  context 'when there are topics' do
    let!(:topics) { create_list(:topic, 2, :with_image) }

    include_examples 'success response'

    it 'returns topics data' do
      get_topics
      expect(json).to include_json(
        topics: Topic.all.map do |t|
          {
            id: t.id,
            description: t.description,
            image_url: polymorphic_url(t.image, only_path: true)
          }
        end
      )
    end
  end

  context 'when there are no topics' do
    include_examples 'success response'

    it 'returns an empty array' do
      get_topics
      expect(json['topics']).to be_empty
    end
  end
end
