require_relative '../../controllers/posts.rb'
require 'json'

describe PostsController do
  before :each do
    @post_data = {
      'id'=> 3, 
      'user_id'=> 'john', 
      'text_content'=> 'john@gmail.com', 
      'attachment'=> '/public/images/a.jpg', 
      'parent_id'=> 1, 
      'created_at'=> '2021-08-1 17:30:00'
    }

    post = double

    allow(post).to receive(:id).and_return(@post_data["id"])
    allow(post).to receive(:parent_id).and_return(nil)
    allow(post).to receive(:user_id).and_return(@post_data["user_id"])
    allow(post).to receive(:email).and_return(@post_data["email"])
    allow(post).to receive(:text_content).and_return(@post_data["text_content"])
    allow(post).to receive(:attachment).and_return(@post_data["attachment"])
    allow(post).to receive(:created_at).and_return(@post_data["created_at"])
    allow(post).to receive(:save).and_return(true)

    allow(Post).to receive(:new).and_return(post)
  end

  describe 'create' do
    context 'when given valid arguments' do
      it "should response with status code 201" do
        expected_response = {
          status: 201,  
          message: 'success',
          data: {
            id: @post_data['id'] ,
            parent_id: nil ,
            user_id: @post_data['user_id'] ,
            text_content: @post_data['text_content'] ,
            attachment: @post_data['attachment'] ,
            created_at: @post_data['created_at']
          }
        }.to_json
          
        params = {
          'user_id' => @post_data['user_id'] ,
          'text_content'=> @post_data['text_content'] ,
          'attachment'=> @post_data['attachment'] ,
        }
        allow(Hashtag).to receive(:save_hashtags_from_post)
        controller = PostsController.new
        response = controller.create(params)
        
        expect(response).to eq(expected_response)
      end
    end

    context 'when given invalid arguments' do
      it "should return status 400 when no user_id is given" do
        expected_response = {
          status: 400,  
          message: 'bad request',
        }.to_json
          
        params = {
          'text_content'=> @post_data['text_content'] ,
          'attachment'=> @post_data['attachment'] ,
        }
        allow(Hashtag).to receive(:save_hashtags_from_post)
        controller = PostsController.new
        response = controller.create(params)
        
        expect(response).to eq(expected_response)
      end

      it "should return status 400 when text_content is not given" do
        expected_response = {
          status: 400,  
          message: 'bad request',
        }.to_json
          
        params = {
          'user_id' => @post_data['user_id'],
          'attachment'=> @post_data['attachment'] ,
        }
        allow(Hashtag).to receive(:save_hashtags_from_post)
        controller = PostsController.new
        response = controller.create(params)
        
        expect(response).to eq(expected_response)
      end

      it "should return status 400 when text_content is an empty string" do
        expected_response = {
          status: 400,  
          message: 'bad request',
        }.to_json
          
        params = {
          'text_content'=> '' ,
          'user_id' => @post_data['user_id'],
          'attachment'=> @post_data['attachment'] ,
        }

        allow(Hashtag).to receive(:save_hashtags_from_post)
        controller = PostsController.new
        response = controller.create(params)
        
        expect(response).to eq(expected_response)
      end
    end
  end

  
end