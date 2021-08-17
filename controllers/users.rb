
require './models/user'
require "sinatra"

class UsersController
  def create(params)
    if params['username'].nil? || params['username'] == '' || params['email'].nil? || params['email'] == ''
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

  def show_by_id(id)
    user = User::find_by_id(id)
    
    return ({
      status: 200,
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