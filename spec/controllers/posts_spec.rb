require_relative '../../controllers/posts.rb'
require 'json'

describe PostsController do
  before :each do
    @post_data = {
      'id'=> 3, 
      'user_id'=> 'john', 
      'text_content'=> 'john@gmail.com', 
      'attachment'=> nil, 
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

    allow(Post).to receive(:find_by_id).and_return(post)
    
    allow(Post).to receive(:find_all).and_return([post])

    allow(Post).to receive(:find_all_by_hashtag).and_return([post])
    allow(Post).to receive(:find_all_by_parent_id).and_return([post])

    allow(Post).to receive(:new).and_return(post)

    @post = post
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
        }
          
        params = {
          'user_id' => @post_data['user_id'] ,
          'text_content'=> @post_data['text_content'] ,
        }
        allow(Hashtag).to receive(:save_hashtags_from_post)
        controller = PostsController.new
        response = controller.create(params)
        
        expect(response).to eq(expected_response)
      end

      it "it should save the file when there is attachment" do
        attachment = double
        allow(attachment).to receive("[]").with("filename").and_return("babi.jpg")
        allow(attachment).to receive(:key?).with("filename").and_return(true)

        file = double
        expect(file).to receive(:write)
        allow(file).to receive(:read)
        allow(attachment).to receive("[]").with("tempfile").and_return(file)
        
        
        allow(File).to receive(:open) { |&block| block.call(file) }
        
        params = {
          'user_id' => @post_data['user_id'] ,
          'text_content'=> @post_data['text_content'],
          'attachment' => attachment
        }
        controller = PostsController.new
        response = controller.create(params)
      end

      it "it should not save the file when there is no attachment" do
        attachment = double
        allow(attachment).to receive("[]").with("filename").and_return("babi.jpg")
        allow(attachment).to receive(:key?).with("filename").and_return(false)

        file = double
        expect(file).to_not receive(:write)
        allow(file).to receive(:read)
        allow(attachment).to receive("[]").with("tempfile").and_return(file)
        
        
        allow(File).to receive(:open) { |&block| block.call(file) }
        
        params = {
          'user_id' => @post_data['user_id'] ,
          'text_content'=> @post_data['text_content'],
          'attachment' => attachment
        }
        controller = PostsController.new
        response = controller.create(params)
      end

      
    end

    context 'when given invalid arguments' do
      it "should return status 400 when no user_id is given" do
        expected_response = {
          status: 400,  
          message: 'bad request',
        }
          
        params = {
          'text_content'=> @post_data['text_content'] ,
          'attachment'=> @post_data['attachment'] ,
        }
        allow(Hashtag).to receive(:save_hashtags_from_post)
        controller = PostsController.new
        response = controller.create(params)
        
        expect(response).to eq(expected_response)
      end

      it "should return status 400 when user_id is an empty string" do
        expected_response = {
          status: 400,  
          message: 'bad request',
        }
          
        params = {
          'user_id' => '' ,
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
        }
          
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
        }
          
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

  describe 'show_by_id' do
    context 'when given valid arguments' do
      it "should return response status 200 with the user data" do
        expected_response = {
          status: 200,  
          message: 'success',
          data: {
            id: @post_data['id'] ,
            parent_id: nil ,
            user_id: @post_data['user_id'] ,
            text_content: @post_data['text_content'] ,
            attachment: @post_data['attachment'] ,
            created_at: @post_data['created_at']
          }
        }
          
        params = @post_data['id']

        controller = PostsController.new
        response = controller.show_by_id(params)
        
        expect(response).to eq(expected_response)
      end
    end

    context 'when no post is found' do
      it "should return response status code 400 bad request" do
        expected_response = {
          status: 404,  
          message: 'resource not found',
        }
          
        params = @post_data['id']

        allow(Post).to receive(:find_by_id).and_return(nil)

        controller = PostsController.new
        response = controller.show_by_id(params)
        
        expect(response).to eq(expected_response)
      end
    end
  end

  describe 'show_all_posts' do
    it 'should response with the data in array form and status code 200' do
      expected_response = {
        status: 200,  
        message: 'success',
        data:[{
          id: @post_data['id'] ,
          parent_id: nil ,
          user_id: @post_data['user_id'] ,
          text_content: @post_data['text_content'] ,
          attachment: @post_data['attachment'] ,
          created_at: @post_data['created_at']
        }]
      }

      controller = PostsController.new
      response = controller.show_all_posts()
      
      expect(response).to eq(expected_response)
    end
  end

  describe 'show_posts_by_hashtag' do
    it 'should response with the data in array form and status code 200' do
      expected_response = {
        status: 200,  
        message: 'success',
        data:[{
          id: @post_data['id'] ,
          parent_id: nil ,
          user_id: @post_data['user_id'] ,
          text_content: @post_data['text_content'] ,
          attachment: @post_data['attachment'] ,
          created_at: @post_data['created_at']
        }]
      }

      controller = PostsController.new
      response = controller.show_posts_by_hashtag("#gigih")
      
      expect(response).to eq(expected_response)
    end
  end

  describe 'show_posts_by_parent_id' do
    it 'should response with the data in array form and status code 200' do
      expected_response = {
        status: 200,  
        message: 'success',
        data:[{
          id: @post_data['id'] ,
          parent_id: nil ,
          user_id: @post_data['user_id'] ,
          text_content: @post_data['text_content'] ,
          attachment: @post_data['attachment'] ,
          created_at: @post_data['created_at']
        }]
      }

      controller = PostsController.new
      response = controller.show_posts_by_parent_id(1)
      
      expect(response).to eq(expected_response)
    end
  end

  describe 'index' do
    context 'when given hashtag as params' do
      it 'should invoke the method to show posts based on their hashtag' do
        params = {
          "hashtag" => "#gigih"
        }
        
        controller = PostsController.new
        expect(controller).to receive(:show_posts_by_hashtag).with(params["hashtag"])
        
        controller.index(params)
      end  
    end
    
  end

end