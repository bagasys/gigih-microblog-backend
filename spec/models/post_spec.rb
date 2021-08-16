require_relative '../../models/post.rb'

describe Post do
  before :each do
    @posts_data = [
      {
        id: 3, 
        user_id: 'john', 
        text_content: 'john@gmail.com', 
        attachment: '/public/images/a.jpg', 
        parent_id: 1, 
        created_at: '2021-08-1 17:30:00'
      }
    ]
    @client = double
    allow(Mysql2::Client).to receive(:new).and_return(@client)
  end

  describe 'initialize' do
    it 'should assign the attributes' do
      post_data = @posts_data[0]
      post = Post.new(
        id: post_data[:id], 
        user_id: post_data[:user_id],
        text_content: post_data[:text_content],
        attachment: post_data[:attachment],
        created_at: post_data[:created_at],
      )

      expect(post.id).to eq(post_data[:id])
      expect(post.user_id).to eq(post_data[:user_id])
      expect(post.text_content).to eq(post_data[:text_content])
      expect(post.attachment).to eq(post_data[:attachment])
      expect(post.created_at).to eq(post_data[:created_at])
    end
  end

  describe 'valid?' do
    context 'given valid arguments' do
      it 'should return true when all arguments are given' do
        post_data = @posts_data[0]
        post = Post.new(
          id: post_data[:id], 
          user_id: post_data[:user_id],
          text_content: post_data[:text_content],
          attachment: post_data[:attachment],
          created_at: post_data[:created_at],
        )
        expect(post.valid?).to be true
      end
    end

    context 'given invalid arguments' do
      it 'should return false when username is nil' do
        post_data = @posts_data[0]
        post = Post.new(
          id: post_data[:id], 
          user_id: post_data[:user_id],
          text_content: nil,
          attachment: post_data[:attachment],
          created_at: post_data[:created_at],
        )
        expect(post.valid?).to be false
      end

      it 'should return false when username is an empty string' do
        post_data = @posts_data[0]
        post = Post.new(
          id: post_data[:id], 
          user_id: post_data[:user_id],
          text_content: '',
          attachment: post_data[:attachment],
          created_at: post_data[:created_at],
        )
        expect(post.valid?).to be false
      end
    end
  end

  describe 'find_by_id' do
    before :each do
      @post_data = @posts_data[0]
        post = Post.new(
          id: @post_data[:id], 
          user_id: @post_data[:user_id],
          text_content: @post_data[:text_content],
          attachment: @post_data[:attachment],
          created_at: @post_data[:created_at],
        )
      @query1 = "SELECT * FROM posts WHERE id = #{@post_data[:id]}"
      query1_response = [{
        'id' => @post_data[:id],
        'user_id' => @post_data[:user_id],
        'text_content' => @post_data[:text_content],
        'attachment' => @post_data[:attachment],
        'created_at' => @post_data[:created_at]
      }]

      allow(@client).to receive(:query).with(@query1).and_return(query1_response)
      allow(@client).to receive(:close)
    end

    it 'should execute queries' do
      expect(@client).to receive(:query).with(@query1)
      expect(@client).to receive(:close)
      Post::find_by_id(@post_data[:id])
    end

    it 'should return a user object' do
      post = Post::find_by_id(@post_data[:id])
      expect(post.id).to eq(@post_data[:id])
      expect(post.created_at).to eq(@post_data[:created_at])
    end
  end

  describe 'save' do
    context 'given invalid arguments' do
      it 'should return false when valid? return false' do
        @post_data = @posts_data[0]
        post = Post.new(
          text_content: '',
          attachment: @post_data[:attachment],
        )
        
        expect(post.save()).to be(false)
      end
    end

    context 'given valid arguments' do
      before :each do
        @post_data = @posts_data[0]
        @query1 = "INSERT INTO posts (user_id, text_content) VALUES ('#{@post_data[:user_id]}', '#{@post_data[:text_content]}')"
        @query2 = "SELECT * FROM posts WHERE id=#{@post_data[:id]}"
        query2_response = [{
        'id' => @post_data[:id],
        'user_id' => @post_data[:user_id],
        'text_content' => @post_data[:text_content],
        'attachment' => @post_data[:attachment],
        'created_at' => @post_data[:created_at]
      }]

        @post = Post.new(
          user_id: @post_data[:user_id],
          text_content: @post_data[:text_content],
        )

        allow(@client).to receive(:query).with(@query1)
        allow(@client).to receive(:last_id).and_return(@post_data[:id])
        allow(@client).to receive(:query).with(@query2).and_return(query2_response)
      end

      it 'should executes the right query when there are no attachment and parent_id' do
        @post = Post.new(
          user_id: @post_data[:user_id],
          text_content: @post_data[:text_content],
        )
        expect(@client).to receive(:query).with(@query1)
        # expect(@client).to receive(:query).with(@query2)
        @post.save()
      end

      it 'should executes the right query when there are attachment and parent_id' do
        @post = Post.new(
          user_id: @post_data[:user_id],
          text_content: @post_data[:text_content],
          parent_id: @post_data[:parent_id],
          attachment: @post_data[:attachment]
        )
        query = "INSERT INTO posts (user_id, text_content, parent_id, attachment) VALUES ('#{@post_data[:user_id]}', '#{@post_data[:text_content]}', #{@post_data[:parent_id]}, '#{@post_data[:attachment]}')"
        expect(@client).to receive(:query).with(query)
        @post.save()
      end


      it 'should return true' do
        expect(@post.save()).to be(true)
      end

      it 'should update the object attributes' do
        @post.save()
        expect(@post.id).to eq(@post_data[:id])
        expect(@post.created_at).to eq(@post_data[:created_at])
      end
    end
  end

 
end