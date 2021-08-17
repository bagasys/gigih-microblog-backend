require './models/post'
require './models/hashtag'
require "sinatra"

class PostsController
  def create(params)
    if params['user_id'].nil?
      return {
        status: 400,  
        message: 'bad request',
      }.to_json
    end

    post = Post.new(user_id: params['user_id'], text_content: params['text_content'], parent_id: params['parent_id'], attachment: params['attachment'])

    if post.save
      Hashtag::save_hashtags_from_post(post.text_content, post.id)
      return ({
      status: 201,
      message: "success",
      data: {
        id: post.id,
        parent_id: post.parent_id,
        user_id: post.user_id,
        text_content: post.text_content,
        attachment: post.attachment,
        created_at: post.created_at
      }
    }).to_json
    end
  end

end