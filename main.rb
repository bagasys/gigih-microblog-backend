require "sinatra"
require "sinatra/namespace"
require "sinatra/json"
require "sinatra/contrib"
require "json"
require 'sinatra/cross_origin'
require_relative './models/user'
require_relative './controllers/users'
require_relative './controllers/posts'
require_relative './controllers/hashtags'

configure do
  enable :cross_origin
end

before do
  content_type :json
  response.headers['Access-Control-Allow-Origin'] = '*'
end

namespace '/api/v1' do
  namespace '/users' do
    get "/:id" do
      controller = UsersController.new
      response = controller.show_by_id(params[:id])
      status response[:status]
      response.to_json
    end

    post "" do
      controller = UsersController.new
      response = controller.create(params)
      status response[:status]
      response.to_json
    end
  end

  namespace '/posts' do
    get "" do
      controller = PostsController.new
      response = controller.index(params)
      status response[:status]
      response.to_json
    end

    post "" do
      controller = PostsController.new
      response = controller.create(params)
      status response[:status]
      response.to_json
    end

    get "/:id" do
      controller = PostsController.new
      response = controller.show_by_id(params[:id])
      status response[:status]
      response.to_json
    end 
  end

  namespace "/hashtags" do
    get "/trendings" do
      controller = HashtagsController.new
      response = controller.show_trending_hashtags
      status response[:status]
      response.to_json
    end
  end

  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end
end
