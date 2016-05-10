module Routes
  module Sessions
    def self.registered(app)
      app.get '/sessions/new' do
        haml :'sessions/new'
      end

      app.post '/sessions' do
        @user = User.first(email: params[:email])
        if BCrypt::Password.new(@user.password).is_password? params[:password]
          session[:user_id] = @user.id
          session[:authenticated] = false

          ConfirmationSender.send_confirmation_to @user

          redirect '/confirmations/new'
        else
          haml :'sessions/new'
        end
      end
    end
  end
end
