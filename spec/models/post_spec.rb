require_relative '../../models/post.rb'

describe Post do
  before :each do
    @posts_data = [
      {
        id: 3, 
        user_id: 1, 
        text_content: 'john@gmail.com', 
        attachment: '/public/images/a.jpg', 
        parent_id: 1, 
        created_at: '2021-08-1 17:30:00'
      },
      {
        id: 2, 
        user_id: 2, 
        text_content: 'doe@gmail.com', 
        attachment: '/public/images/a.jpg', 
        parent_id: 3, 
        created_at: '2021-08-1 17:30:00'
      }
    ]
    @client = double
    allow(@client).to receive(:close)
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

  describe 'generate_insert_post_query_text' do
    it 'right query when there are no attachment and parent_id' do
      post = Post.new(
        user_id: 1,
        text_content: "Hehe",
      )
      query = "INSERT INTO posts (user_id, text_content) VALUES (1, 'Hehe')"
      expect(post.generate_insert_post_query_text).to eq(query)
    end

    it 'should executes the right query when there are attachment and parent_id' do
      post = Post.new(
        user_id: 1,
        text_content: "Hehe",
        parent_id: 2,
        attachment: "a.jpg"
      )
      query = "INSERT INTO posts (user_id, text_content, parent_id, attachment) VALUES (1, 'Hehe', 2, 'a.jpg')"
      expect(post.generate_insert_post_query_text).to eq(query)
    end

    it 'should executes the right query when there is an attachment and no parent_id' do
      post = Post.new(
        user_id: 1,
        text_content: "Hehe",
        attachment: "a.jpg"
      )
      query = "INSERT INTO posts (user_id, text_content, attachment) VALUES (1, 'Hehe', 'a.jpg')"
      expect(post.generate_insert_post_query_text).to eq(query)
      
    end

    it 'should executes the right query when there is a parent_id but no attachment' do
      post = Post.new(
        user_id: 1,
        text_content: "Hehe",
        parent_id: 2
      )
      query = "INSERT INTO posts (user_id, text_content, parent_id) VALUES (1, 'Hehe', 2)"
      expect(post.generate_insert_post_query_text).to eq(query)
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
        @query1 = "INSERT INTO posts (user_id, text_content) VALUES (#{@post_data[:user_id]}, '#{@post_data[:text_content]}')"
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

      it 'should close the db connection' do
        expect(@client).to receive(:close)
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

  describe 'find_all' do
    before :each do
      @query_result = @posts_data
      allow(@client).to receive(:query).and_return(@query_result)
      allow(@client).to receive(:close)
    end
    it "should close the db connection." do
      expect(@client).to receive(:close)
      posts = Post::find_all
    end

    it "should return empty array when the query return 0 rows" do
      allow(@client).to receive(:query).and_return([])
      
      expect(Post::find_all).to eq([])
    end

    it "should return an array which length equals to query result" do
      allow(@client).to receive(:query).and_return(@posts_data)
      
      expect(Post::find_all.length).to eq(@posts_data.length)
    end
  end

  describe 'find_all_by_hashtag' do
    before :each do
      @query_result = @posts_data
      allow(@client).to receive(:query).and_return(@query_result)
      allow(@client).to receive(:close)
    end

    it "should close the db connection." do
      expect(@client).to receive(:close)
      posts = Post::find_all_by_hashtag("#gigih")
    end

    it "should return empty array when the query return 0 rows" do
      allow(@client).to receive(:query).and_return([])
      
      expect(Post::find_all_by_hashtag("#Gigih")).to eq([])
    end

    it "should return an array which length equals to query result" do
      allow(@client).to receive(:query).and_return(@posts_data)
      
      expect(Post::find_all_by_hashtag("#Gigih").length).to eq(@posts_data.length)
    end

    it "should add # sign if the argument given doesn't contain # sign." do
      expect(@client).to receive(:query).with("SELECT * FROM posts WHERE id IN (SELECT post_id FROM hashtags WHERE name='#GIGIH')").and_return(@posts_data)
      
      Post::find_all_by_hashtag("GIGIH")
    end

    it "should return an empty array if empty string is given as argument." do
      expect(Post::find_all_by_hashtag("")).to eq([])
    end
  end

  describe 'find_all_by_parent_id' do
    before :each do
      @query_result = @posts_data
      allow(@client).to receive(:query).and_return(@query_result)
      allow(@client).to receive(:close)
    end


    it "should close the db connection." do
      expect(@client).to receive(:close)
      posts = Post::find_all_by_parent_id(1)
    end

    it "should return empty array when the query return 0 rows" do
      allow(@client).to receive(:query).and_return([])
      
      expect(Post::find_all_by_parent_id(1)).to eq([])
    end

    it "should return an array which length equals to query result" do
      allow(@client).to receive(:query).and_return(@posts_data)
      
      expect(Post::find_all_by_parent_id(1).length).to eq(@posts_data.length)
    end

    it "should execute the right query" do
      expect(@client).to receive(:query).with("SELECT * FROM posts WHERE parent_id = #{1}").and_return(@posts_data)
      
      Post::find_all_by_parent_id(1)
    end
  end

  describe 'to_hash' do
    it "should return a hash of instance states" do
      params = {
        :id => 1,
        :parent_id => 2,
        :user_id => 3,
        :text_content => "Halooo",
        :attachment => "files/a.jpg",
        :created_at => "2021-08-1 17:30:00"
      }
      post = Post.new(params)
      expect(post.to_hash).to eq(params)
    end
  end

  describe  'extract_hashtags_from_text_content' do
    it "should return list of the hashtags exists in @text_content" do
      params = {
        :id => 1,
        :parent_id => 2,
        :user_id => 3,
        :text_content => "Halooo #GIGIH #BISA",
        :attachment => "files/a.jpg",
        :created_at => "2021-08-1 17:30:00"
      }
      post = Post.new(params)
      expect(post.extract_hashtags_from_text_content).to eq(["#gigih", "#bisa"])
    end

    it "should return list of the unique hashtags exists in @text_content" do
      params = {
        :id => 1,
        :parent_id => 2,
        :user_id => 3,
        :text_content => "Halooo #GIGIH #GIGIH #BISA",
        :attachment => "files/a.jpg",
        :created_at => "2021-08-1 17:30:00"
      }
      post = Post.new(params)
      expect(post.extract_hashtags_from_text_content).to eq(["#gigih", "#bisa"])
    end

    it "should be case insensitive" do
      params = {
        :id => 1,
        :parent_id => 2,
        :user_id => 3,
        :text_content => "Halooo #GIGIH #gigih #BISA",
        :attachment => "files/a.jpg",
        :created_at => "2021-08-1 17:30:00"
      }
      post = Post.new(params)
      expect(post.extract_hashtags_from_text_content).to eq(["#gigih", "#bisa"])
    end
  end

  describe 'generate_insert_hashtags_query_text' do
    it "should return an empty string if there is no hashtags" do
      params = {
        :id => 1,
        :parent_id => 2,
        :user_id => 3,
        :text_content => "Halooo ",
        :attachment => "files/a.jpg",
        :created_at => "2021-08-1 17:30:00"
      }
      post = Post.new(params)
      expect(post.generate_insert_hashtags_query_text).to eq("")
    end

    it "should return the right query if there is hashtag(s)" do
      params = {
        :id => 1,
        :parent_id => 2,
        :user_id => 3,
        :text_content => "Halooo  #gigih #bisa",
        :attachment => "files/a.jpg",
        :created_at => "2021-08-1 17:30:00"
      }
      post = Post.new(params)
      expect(post.generate_insert_hashtags_query_text).to eq("INSERT INTO hashtags (post_id, name) VALUES (1, '#gigih'), (1, '#bisa')")
    end
  end
end