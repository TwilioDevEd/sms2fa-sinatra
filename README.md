<a href="https://www.twilio.com">
  <img src="https://static0.twilio.com/marketing/bundles/marketing/img/logos/wordmark-red.svg" alt="Twilio" width="250" />
</a>

# SMS Two Factor Authentication with Sinatra and Twilio

[![Build and test](https://github.com/TwilioDevEd/sms2fa-sinatra/actions/workflows/build_test.yml/badge.svg)](https://github.com/TwilioDevEd/sms2fa-sinatra/actions/workflows/build_test.yml)

If for some reason you're not able to use Authy, you can implement two factor
authentication yourself using SMS messages.

[Read the full tutorial here!](https://www.twilio.com/docs/tutorials/walkthrough/sms-two-factor-authentication/ruby/sinatra)

## Get started

This project is built using the [Sinatra](http://www.sinatrarb.com/) web framework.

1. First clone this repository and `cd` into it.

   ```bash
   git clone git@github.com:TwilioDevEd/sms2fa-sinatra.git
   cd sms2fa-sinatra
   ```

1. Install the dependencies.

   ```bash
   bundle install
   ```

1. Copy the sample configuration file and edit it to match your configuration.

   ```bash
   cp .env.example .env
   ```

   You can find your `TWILIO_ACCOUNT_SID` and `TWILIO_AUTH_TOKEN` in your
   [Twilio Account Settings](https://www.twilio.com/user/account/settings).
   You will also need a `TWILIO_NUMBER`, you may find [here](https://www.twilio.com/user/account/phone-numbers/incoming).

1. Create development and test databases.

   Make sure you have installed [PostgreSQL](http://www.postgresql.org/). If on
   a Mac, I recommend [Postgres.app](http://postgresapp.com).

   ```bash
   createdb sms_two_fa_sinatra
   createdb sms_two_fa_sinatra_test
   ```

1. Make sure the tests succeed.

   ```bash
   bundle exec rspec
   ```

1. Start the server.

   ```bash
   bundle exec rackup
   ```

1. Check it out at [http://localhost:9292](http://localhost:9292).

### Configure Development vs Production Settings

By default, this application will run in production mode - stack traces will not be visible in the web browser. If you would like to run this application in development locally, change the `APP_ENV` variable in your `.env` file.

`APP_ENV=development`

For more about development vs production, visit [Sinatra's configuration page](http://sinatrarb.com/configuration.html).

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
