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

          VerificationSender.send_verification_to @user

          redirect '/confirmations/new'
        else
          flash.now[:error] = "Wrong user/password."
          haml :'sessions/new'
        end
      end

      app.get '/sessions/destroy' do
        session[:user_id] = nil
        session[:authenticated] = nil

        flash.now[:notice] = "See you soon!"
        haml :'sessions/new'
      end
    end
  end
end
