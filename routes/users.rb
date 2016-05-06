require_relative '../lib/code_generator'

module Routes
  module Users
    def self.registered(app)
      app.get '/users/new' do
        @user = User.new
        haml :'users/new'
      end

      app.post '/users' do
        user_params = {
          first_name:   params[:first_name],
          last_name:    params[:last_name],
          email:        params[:email],
          phone_number: params[:phone_number],
          password:     params[:password]
        }

        @user = User.new(user_params)
        if @user.save
          session[:user_id] = @user.id
          ConfirmationSender.send_confirmation_to(@user)
          redirect '/'
        else
          haml :'users/new'
        end
      end
    end
  end
end
