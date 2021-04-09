json.extract! topic, :id, :description
json.image_url url_for(topic.image) if topic.image.attached?
