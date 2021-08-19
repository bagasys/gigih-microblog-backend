
require './models/user'
require "sinatra"

class UsersController
  def create(params)
    user = User.new(username: params[:username], email: params[:email], bio: params[:bio])

    if !user.valid? 
      return ({
        status: 400,
        message: "bad request"
      })
    end

    if user.exist? 
      return ({
        status: 400,
        message: "user with the same email or username is exist already"
      })
    end

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