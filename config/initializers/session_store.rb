# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_edges_session',
  :secret      => 'bd936da5d5433c715ca3e77b1a795360166ad896c301e5ea88df5c82ff656d61a35cd8076585f0b99585291956bc521e6ed54c6755217c1be089d13de3765de1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
