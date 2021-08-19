require_relative '../../models/user.rb'

describe User do
  before :each do
    @users_data = [
      {
        id: 1, 
        username: 'john', 
        email: 'john@gmail.com', 
        bio: 'Good day :).', 
        created_at: '2021-08-1 17:30:00'
      }
    ]
    @client = double
    allow(Mysql2::Client).to receive(:new).and_return(@client)
  end

  describe 'initialize' do
    it 'should assign the attributes' do
      user_data = @users_data[0]
      user = User.new(
        id: user_data[:id], 
        username: user_data[:username],
        email: user_data[:email],
        bio: user_data[:bio],
        created_at: user_data[:created_at],
      )

      expect(user.id).to eq(user_data[:id])
      expect(user.username).to eq(user_data[:username])
      expect(user.email).to eq(user_data[:email])
      expect(user.bio).to eq(user_data[:bio])
      expect(user.created_at).to eq(user_data[:created_at])
    end

    context 'bio is not given' do
      it 'should assign empty string to bio' do
        user_data = @users_data[0]
        user = User.new(
          id: user_data[:id], 
          username: user_data[:username],
          email: user_data[:email],
          created_at: user_data[:created_at],
        )
        expect(user.bio).to eq('')
      end
    end
  end

  describe 'valid?' do
    context 'given valid arguments' do
      it 'should return true when all arguments are given' do
        user_data = @users_data[0]
        user = User.new(
          id: user_data[:id], 
          username: user_data[:username],
          email: user_data[:email],
          bio: user_data[:bio],
          created_at: user_data[:created_at],
        )
        expect(user.valid?).to be true
      end
    end

    context 'given invalid arguments' do
      it 'should return false when username is nil' do
        user_data = @users_data[0]
        user = User.new(
          id: user_data[:id], 
          email: user_data[:email],
          bio: user_data[:bio],
          created_at: user_data[:created_at],
        )
        expect(user.valid?).to be false
      end

      it 'should return false when username is an empty string' do
        user_data = @users_data[0]
        user = User.new(
          id: user_data[:id], 
          username: '',
          email: user_data[:email],
          bio: user_data[:bio],
          created_at: user_data[:created_at],
        )
        expect(user.valid?).to be false
      end

      it 'should return false when email is nil' do
        user_data = @users_data[0]
        user = User.new(
          id: user_data[:id], 
          username: user_data[:username],
          bio: user_data[:bio],
          created_at: user_data[:created_at],
        )
        expect(user.valid?).to be false
      end

      it 'should return false when email is an empty string' do
        user_data = @users_data[0]
        user = User.new(
          id: user_data[:id],
          email: '',
          username: user_data[:username],
          bio: user_data[:bio],
          created_at: user_data[:created_at],
        )
        expect(user.valid?).to be false
      end

      it 'should return false when bio is nil' do
        user_data = @users_data[0]
        user = User.new(
          id: user_data[:id], 
          username: user_data[:username],
          email: user_data[:email],
          created_at: user_data[:created_at],
        )
        user.bio = nil
        expect(user.valid?).to be false
      end
    end
  end

  describe 'save' do
    context 'given valid arguments' do
      before :each do
        @user_data = @users_data[0]
        @query1 = "INSERT INTO users (username, email, bio) VALUES ('#{@user_data[:username]}', '#{@user_data[:email]}', '#{@user_data[:bio]}')"
        @query2 = "SELECT * FROM users WHERE id=#{@user_data[:id]}"
        query2_responses = [{
          'id' => @user_data[:id],
          'username' => @user_data[:username],
          'email' => @user_data[:email],
          'bio' => @user_data[:bio],
          'created_at' => @user_data[:created_at]
        }]

        @user = User.new(
          username: @user_data[:username],
          email: @user_data[:email],
          bio: @user_data[:bio],
        )

        allow(@client).to receive(:query).with(@query1)
        allow(@client).to receive(:last_id).and_return(@user_data[:id])
        allow(@client).to receive(:query).with(@query2).and_return(query2_responses)
      end

      it 'should executes queries' do
        expect(@client).to receive(:query).with(@query1)
        expect(@client).to receive(:last_id)
        expect(@client).to receive(:query).with(@query2)
        @user.save()
      end

      it 'should update the object attributes' do
        @user.save()
        expect(@user.id).to eq(@user_data[:id])
        expect(@user.created_at).to eq(@user_data[:created_at])
      end

      it 'should return true' do
        expect(@user.save()).to be(true)
      end
    end
    
    context 'given invalid arguments' do
      it 'should return false when valid? return false' do
        user_data = @users_data[0]
        user = User.new(
          username: nil,
          email: user_data[:email],
          bio: user_data[:bio],
        )
        expect(user.save()).to be(false)
      end
    end
  end

  describe 'find_by_id' do
    before :each do
      @user_data = @users_data[0]
      @query1 = "SELECT * FROM users WHERE id = #{@user_data[:id]}"
      query1_response = [{
        'id' => @user_data[:id],
        'username' => @user_data[:username],
        'email' => @user_data[:email],
        'bio' => @user_data[:bio],
        'created_at' => @user_data[:created_at]
      }]

      allow(@client).to receive(:query).with(@query1).and_return(query1_response)
      allow(@client).to receive(:close)
    end

    it 'should execute queries' do
      expect(@client).to receive(:query).with(@query1)
      expect(@client).to receive(:close)
      User::find_by_id(@user_data[:id])
    end

    it 'should return a user object' do
      user = User::find_by_id(@user_data[:id])
      expect(user.id).to eq(@user_data[:id])
      expect(user.created_at).to eq(@user_data[:created_at])
    end
  end

  describe 'find_by_username' do
    before :each do
      @user_data = @users_data[0]
      @query1 = "SELECT * FROM users WHERE username = #{@user_data[:username]}"
      query1_response = [{
        'id' => @user_data[:id],
        'username' => @user_data[:username],
        'email' => @user_data[:email],
        'bio' => @user_data[:bio],
        'created_at' => @user_data[:created_at]
      }]

      allow(@client).to receive(:query).with(@query1).and_return(query1_response)
      allow(@client).to receive(:close)
    end

    it 'should execute queries' do
      expect(@client).to receive(:query).with(@query1)
      expect(@client).to receive(:close)
      User::find_by_username(@user_data[:username])
    end

    it 'should return a user object' do
      user = User::find_by_username(@user_data[:username])
      expect(user.id).to eq(@user_data[:id])
      expect(user.created_at).to eq(@user_data[:created_at])
    end
  end

  describe 'to_hash' do
    it "should return a hash of the instance states" do
      params = {
        :id => 1,
        :username => 'bagasys',
        :email => 'bagasys@gmail.com',
        :bio => 'haiii',
        :created_at => '2021-08-1 17:30:00'
      }
      post = User.new(params)
      expect(post.to_hash).to eq(params)
    end
  end
end