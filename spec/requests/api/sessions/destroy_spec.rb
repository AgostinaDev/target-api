require 'rails_helper'

RSpec.describe 'DELETE api/v1/users/sign_out', type: :request do
  let(:user) { create(:user) }

  subject(:sign_out) { delete destroy_user_session_path, headers: auth_headers, as: :json }

  context 'destroying a valid user session' do
    it 'returns success' do
      sign_out
      expect(response).to be_successful
    end

    it 'returns invalid token authentication data' do
      sign_out
      token = response.header['access-token']
      client = response.header['client']
      expect(token).to be_nil
      expect(client).to be_nil
    end

    it 'removes user token' do
      headers = auth_headers
      expect {
        delete destroy_user_session_path, headers: headers, as: :json
      }.to change { user.reload.tokens.size }.by(-1)
    end
  end

  context 'using invalid token' do
    it 'returns not found' do
      delete destroy_user_session_path, headers: {}, as: :json
      expect(response).to have_http_status(:not_found)
    end
  end
end
