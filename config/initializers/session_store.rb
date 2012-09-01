# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_heypin_retail_session',
  :secret      => 'c612cab56ee44a38665497e5eedeba5189e219ed6820ffb54a9e798f1c30eee4f4ca938af070a8fd71b0ce0c35f365850ee328bd28cbf4732798ecfb4abb5d29'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
