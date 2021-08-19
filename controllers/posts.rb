require './models/post'
require './models/hashtag'
require "sinatra"

class PostsController
  def create(params)
    if params['user_id'].nil? || params['text_content'].nil? || params['text_content'] == '' || params['user_id'] == ''
      return {
        status: 400,  
        message: 'bad request',
      }
    end

    attachment = nil 
    if params.key?("attachment") && params["attachment"].key?("filename")
      file_name = params["attachment"]["filename"]
      file = params["attachment"]["tempfile"]
      file_path = "./public/files/#{file_name}" 
      attachment = file_name
      File.open(file_path, 'wb') do |f|
        f.write(file.read)
      end
    end

    post = Post.new(user_id: params['user_id'], text_content: params['text_content'], parent_id: params['parent_id'], attachment: attachment)

    if post.save
      Hashtag::save_hashtags_from_post(post.text_content, post.id)
      return ({
      status: 201,
      message: "success",
      data: post.to_hash
    })
    end
  end

  def show_by_id(id)
    post = Post::find_by_id(id)
    
    if post == nil
      return ({
        status: 404,
        message: "resource not found"
      })
    end

    return ({
      status: 200,
      message: "success",
      data: post.to_hash
    })
  end


  def index(params)
    if params["hashtag"]
      self.show_posts_by_hashtag(params["hashtag"])
    else
      self.show_all_posts()
    end
  end

  def show_all_posts()
    posts = Post::find_all
    
    data = posts.map { |post| post.to_hash }

    return ({
      status: 200,
      message: "success",
      data: data
    })
  end

  def show_posts_by_hashtag(hashtag)
    posts = Post::find_all_by_hashtag(hashtag)
    
    data = posts.map { |post| post.to_hash }

    return ({
      status: 200,
      message: "success",
      data: data
    })
  end

  def show_posts_by_parent_id(parent_id)
    posts = Post::find_all_by_parent_id(parent_id)
    
    data = []
    posts.each do |post|
      data << post.to_hash
    end

    return ({
      status: 200,
      message: "success",
      data: data
    })
  end
end