require "sinatra"
require "sinatra/namespace"
require "sinatra/json"
require "sinatra/contrib"
require "json"
require_relative './models/user'
require_relative './controllers/users'
require_relative './controllers/posts'
require_relative './controllers/hashtags'

before do
  content_type :json
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
end
