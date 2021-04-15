json.extract! target, :id, :title, :radius, :latitude, :longitude, :user_id

json.topic do
  json.partial! 'api/v1/topics/info', topic: target.topic
end
