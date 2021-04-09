require 'rails_helper'

RSpec.describe 'POST /api/v1/users', type: :request do
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:password) { Faker::Internet.password }
  let(:password_confirmation) { password }
  let(:email) { Faker::Internet.unique.email }
  let(:subject) { post user_registration_path, params: params, as: :json }
  let(:gender) { User.genders.values.sample }
  let(:params) do
    {
      user: {
        first_name: first_name,
        last_name: last_name,
        gender: gender,
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }
  end

  let(:user) { User.last }

  subject(:create_user) { post user_registration_path, params: params, as: :json }

  context 'using valid sign up data' do
    it 'returns success' do
      create_user
      expect(response).to be_successful
    end

    it 'adds a new user' do
      expect { create_user }.to change { User.count }.by(1)
    end

    it 'returns user data' do
      create_user
      expect(json).to include_json(
        user: {
          id: user.id,
          first_name: first_name,
          last_name: last_name,
          gender: gender,
          email: email
        }
      )
    end

    it 'returns valid token authentication data' do
      create_user
      token = response.header['access-token']
      client = response.header['client']
      expect(user.reload.valid_token?(token, client)).to be_truthy
    end
  end

  context 'using invalid sign up data' do
    let(:password_confirmation) { 'invalidPassword' }

    it 'returns unprocessable entity response' do
      create_user
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'doesn\'t return user' do
      create_user
      expect(json['user']).to be_nil
    end

    it 'returns invalid token authentication data' do
      create_user
      token = response.header['access-token']
      client = response.header['client']
      expect(token).to be_nil
      expect(client).to be_nil
    end
  end
end
