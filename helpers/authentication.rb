module Helpers
  module Authentication
    # Authentication
    def authenticate!
      redirect '/' unless authenticated?
    end

    def authenticated?
      !!session[:authenticated]
    end
  end
end
