require 'rails_helper'

RSpec.describe 'POST api/v1/users/sign_in', type: :request do
  let(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_password) { user.password }
  let(:params) do
    {
      user: {
        email: user_email,
        password: user_password
      }
    }
  end

  subject(:sign_in) { post user_session_path, params: params, as: :json }

  context 'using valid sign in data' do
    it 'returns success' do
      sign_in
      expect(response).to be_successful
    end

    it 'returns user data' do
      sign_in
      expect(json).to include_json(
        user: {
          id: user.id,
          first_name: user.first_name,
          last_name: user.last_name,
          gender: user.gender,
          email: user.email
        }
      )
    end

    it 'returns valid token authentication data' do
      sign_in
      token = response.header['access-token']
      client = response.header['client']
      expect(user.reload.valid_token?(token, client)).to be_truthy
    end

    it 'adds user token' do
      headers = auth_headers
      expect { sign_in }.to change { user.reload.tokens.size }.by(1)
    end
  end

  context 'using invalid sign in data' do
    let(:user_password) { 'InvalidPassword' }

    before do
      sign_in
    end

    it 'returns unauthorized response' do
      expect(response).to be_unauthorized
    end

    it 'doesn\'t return user' do
      expect(json['user']).to be_nil
    end

    it 'returns invalid token authentication data' do
      token = response.header['access-token']
      client = response.header['client']
      expect(token).to be_nil
      expect(client).to be_nil
    end
  end
end
