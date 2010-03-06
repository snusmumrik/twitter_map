# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_format_session',
  :secret      => '751edcaa99e3fed0660b4bf73952d4ff12fc9c70cb3da1f25187540c5aea50ad689309bd75c115b9514ff70e5ebf5010635bf6eee8799b0aff6aa8b1298e630c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
