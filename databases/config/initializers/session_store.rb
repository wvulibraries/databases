# Configure the session store to use the database
Rails.application.config.session_store :active_record_store, 
  key: '_databases_session',
  secure: Rails.env.production?,
  httponly: true,
  expire_after: 2.hours

# Configure serialization for session data
ActiveRecord::SessionStore::Session.serializer = :json