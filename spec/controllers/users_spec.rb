require_relative '../../controllers/users.rb'
require 'json'
describe UsersController do
  before :each do
    @user = double
    @user_data = {
      "id" => 1,
      "username" => "boyboyboy",
      "email" => "boy@gmail.com",
      "bio" => "Hi, Boy!",
      "created_at" => '2021-08-1 17:30:00'
    }
    allow(@user).to receive(:id).and_return(@user_data["id"])
    allow(@user).to receive(:username).and_return(@user_data["username"])
    allow(@user).to receive(:email).and_return(@user_data["email"])
    allow(@user).to receive(:bio).and_return(@user_data["bio"])
    allow(@user).to receive(:created_at).and_return(@user_data["created_at"])
    allow(@user).to receive(:save).and_return(true)

    allow(User).to receive(:find_by_id).and_return(@user)

    allow(User).to receive(:find_by_username).and_return(@user)

    allow(User).to receive(:new).and_return(@user)
  end


  describe 'create' do
    context 'when given valid arguments' do
      it "should return the right response" do
        user_hash = {
          id: @user_data['id'],
          username: @user_data['username'],
          email: @user_data['email'],
          bio: @user_data['bio'],
          created_at: @user_data['created_at'],
        }

        expected_response = {
          status: 201,  
          message: 'success',
          data: user_hash
        }
          
        allow(@user).to receive(:to_hash).and_return(user_hash)

        params = {
          'username' => @user_data['username'],
          'email' => @user_data['email'],
          'bio' => @user_data['bio'],
        }
        allow(@user).to receive(:valid?).and_return(true)
        allow(@user).to receive(:exist?).and_return(false)

        controller = UsersController.new
        response = controller.create(params)
        expect(response).to eq(expected_response)
      end
    end

    context 'when given invalid arguments' do
      it "should return status 400" do
        expected_response = {
          status: 400,  
          message: 'bad request',
        }
          
        params = {
          'email' => @user_data['email'],
          'bio' => @user_data['bio'],
        }
        allow(@user).to receive(:valid?).and_return(false)

        controller = UsersController.new
        response = controller.create(params)
        expect(response).to eq(expected_response)
      end

      it "should return status 400 when user already exist" do
        expected_response = {
          status: 400,  
          message: 'user with the same email or username is exist already',
        }
          
        params = {
          'email' => @user_data['email'],
          'bio' => @user_data['bio'],
        }
        allow(@user).to receive(:valid?).and_return(true)
        allow(@user).to receive(:exist?).and_return(true)
        controller = UsersController.new
        response = controller.create(params)
        expect(response).to eq(expected_response)
      end
    end
  end

  describe 'show_by_id' do
    context 'when given valid arguments' do
      it "should return response status 200 with the user data" do
        user_hash = {
          id: @user_data['id'],
          username: @user_data['username'],
          email: @user_data['email'],
          bio: @user_data['bio'],
          created_at: @user_data['created_at'],
        }
        
        expected_response = {
          status: 200,  
          message: 'success',
          data: user_hash
        }
          
        allow(@user).to receive(:to_hash).and_return(user_hash)

        params = @user_data['id']

        controller = UsersController.new
        response = controller.show_by_id(params)
        expect(response).to eq(expected_response)
      end
    end

    context 'no user found' do
      it "should return response status 404 not found" do
        expected_response = {
          status: 404,  
          message: 'resource not found',
        }
          
        params = @user_data['id']

        allow(User).to receive(:find_by_id).and_return(nil)

        controller = UsersController.new
        response = controller.show_by_id(params)
        expect(response).to eq(expected_response)
      end
    end
  end

  describe 'show_by_username' do
    context 'when given valid arguments' do
      it "should return response status 200 with the user data" do
        user_hash = {
          id: @user_data['id'],
          username: @user_data['username'],
          email: @user_data['email'],
          bio: @user_data['bio'],
          created_at: @user_data['created_at'],
        }

        expected_response = {
          status: 200,  
          message: 'success',
          data: user_hash
        }
         
        allow(@user).to receive(:to_hash).and_return(user_hash)

        params = @user_data['username']

        controller = UsersController.new
        response = controller.show_by_username(params)
        expect(response).to eq(expected_response)
      end
    end

    context 'no user found' do
      it "should return response status 404 not found" do
        expected_response = {
          status: 404,  
          message: 'resource not found',
        }
          
        params = @user_data['username']

        allow(User).to receive(:find_by_username).and_return(nil)

        controller = UsersController.new
        response = controller.show_by_username(params)
        expect(response).to eq(expected_response)
      end
    end
  end
end