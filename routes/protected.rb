module Routes
  module Protected
    def self.registered(app)
      app.get '/protected' do
        authenticate!
        haml :'protected/index'
      end
    end
  end
end
