
require './models/user'
require "sinatra"

class UsersController
  def create(params)
    if params['username'].nil? || params['email'].nil?
      return ({
        status: 400,
        message: "bad request"
      }).to_json
    end
    
    user = User.new(username: params[:username], email: params[:email], bio: params[:bio])
    
    if user.save
      return ({
      status: 201,
      message: "success",
      data: {
        id: user.id,
        username: user.username,
        email: user.email,
        bio: user.bio,
        created_at: user.created_at
      }
    }).to_json
    end
  end
end