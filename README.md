# SMS Two Factor Authentication with Sinatra and Twilio

[![Build Status](https://travis-ci.org/TwilioDevEd/sms2fa-sinatra.svg?branch=master)](https://travis-ci.org/TwilioDevEd/sms2fa-sinatra)

## Local development

This project is built using the [Sinatra](http://www.sinatrarb.com/) web framework.

1. First clone this repository and `cd` into it.

   ```bash
   $ git clone git@github.com:TwilioDevEd/sms2fa-sinatra.git
   $ cd sms2fa-sinatra
   ```

1. Install the dependencies.

   ```bash
   $ bundle install
   ```

1. Copy the sample configuration file and edit it to match your configuration.

   ```bash
   $ cp .env.example .env
   ```

   You can find your `TWILIO_ACCOUNT_SID` and `TWILIO_AUTH_TOKEN` in your
   [Twilio Account Settings](https://www.twilio.com/user/account/settings).
   You will also need a `TWILIO_PHONE_NUMBER`, which you may find [here](https://www.twilio.com/user/account/phone-numbers/incoming).

   Run `source .env` to export the environment variables.

1. Create development and test databases.

   _Make sure you have installed [PostgreSQL](http://www.postgresql.org/). If on
   a Mac, I recommend [Postgres.app](http://postgresapp.com)_.

   ```bash
   $ createdb sms_two_fa_sinatra
   $ createdb sms_two_fa_sinatra_test
   ```

1. Make sure the tests succeed.

   ```bash
   $ bundle exec rspec
   ```

1. Start the server.

   ```bash
   $ bundle exec rackup
   ```

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
