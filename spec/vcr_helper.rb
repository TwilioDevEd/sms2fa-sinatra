VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/cassettes"
  config.hook_into :fakeweb
  config.filter_sensitive_data("<TWILIO ACCOUNT SID>") { ENV["TWILIO_ACCOUNT_SID"] }
  config.filter_sensitive_data("<TWILIO AUTH TOKEN>") { ENV["TWILIO_AUTH_TOKEN"] }
  config.filter_sensitive_data("<TWILIO NUMBER>") { ENV["TWILIO_NUMBER"] }
end
