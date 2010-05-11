# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_settings_session',
  :secret      => '7b9dbac4706b1d8660f7946b707705d7db58d8149a821604c69c649fb1e31c0fea6731132e8021eb885fffd86b621d6b929366f6efa9f28784ab3f0581ca4d2a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
