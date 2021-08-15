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
    end
  end

  
end