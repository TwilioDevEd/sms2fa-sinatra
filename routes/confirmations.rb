module Routes
  module Confirmations
    def self.registered(app)
      app.get '/confirmations/new' do
        @user = User.get(session[:user_id])
        haml :'confirmations/new'
      end

      app.post '/confirmations' do
        @user = User.get(params[:user_id])
        if @user.verification_code == params[:verification_code]
          @user.update(confirmed: true)

          session[:authenticated] = true

          flash[:notice] = "Welcome #{@user.first_name}. The Adventure Begins!"
          redirect '/protected'
        else
          flash.now[:error] = "Verification code is incorrect."
          haml :'confirmations/new'
        end
      end
    end
  end
end
