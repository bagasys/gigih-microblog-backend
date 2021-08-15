require "sinatra"
require "sinatra/json"
require "json"
before do
  content_type :json
end

get "/api/v1" do
  
  status 200
  json({
    status: 200,
    message: "Success!",
    data: {}
  })
end
