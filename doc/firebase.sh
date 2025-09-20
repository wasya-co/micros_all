

curl -X POST \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  https://fcm.googleapis.com/v1/projects/YOUR_PROJECT_ID/messages:send \
  -d '{
    "message": {
      "token": "DEVICE_REGISTRATION_TOKEN",
      "notification": {
        "title": "Hello",
        "body": "World"
      }
    }
  }'

