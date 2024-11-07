Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3000'  # Adjust according to your React app's URL
      resource '/api/v1/*',
               headers: :any,
               methods: [:get, :post, :put, :delete, :options, :head]
    end
end
  