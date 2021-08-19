
require './models/user'
require "sinatra"

class UsersController
  def create(params)
    if params['username'].nil? || params['username'] == '' || params['email'].nil? || params['email'] == ''
      return ({
        status: 400,
        message: "bad request"
      })
    end
    
    user = User.new(username: params[:username], email: params[:email], bio: params[:bio])
    
    if user.save
      return ({
      status: 201,
      message: "success",
      data: user.to_hash
    })
    end
  end

  def show_by_id(id)
    user = User::find_by_id(id)
    
    if user == nil
      return ({
        status: 404,
        message: "resource not found"
      })
    end

    return ({
      status: 200,
      message: "success",
      data: user.to_hash
    })
  end

  def show_by_username(username)
    user = User::find_by_username(username)
    
    if user == nil
      return ({
        status: 404,
        message: "resource not found"
      })
    end

    return ({
      status: 200,
      message: "success",
      data: user.to_hash
    })
  end
end