def json
  JSON.parse(response.body).with_indifferent_access
end

def auth_headers
  user.create_new_auth_token
end
