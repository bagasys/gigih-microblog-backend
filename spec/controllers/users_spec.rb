require_relative '../../controllers/users.rb'
require 'json'
describe UsersController do
  before :each do
    user = double
    @user_data = {
      "id" => 1,
      "username" => "boyboyboy",
      "email" => "boy@gmail.com",
      "bio" => "Hi, Boy!",
      "created_at" => '2021-08-1 17:30:00'
    }
    allow(user).to receive(:id).and_return(@user_data["id"])
    allow(user).to receive(:username).and_return(@user_data["username"])
    allow(user).to receive(:email).and_return(@user_data["email"])
    allow(user).to receive(:bio).and_return(@user_data["bio"])
    allow(user).to receive(:created_at).and_return(@user_data["created_at"])
    allow(user).to receive(:save).and_return(true)

    allow(User).to receive(:find_by_id).and_return(user)

    allow(User).to receive(:find_by_username).and_return(user)

    allow(User).to receive(:new).and_return(user)
  end


  describe 'create' do
    context 'when given valid arguments' do
      it "should return the right response" do
        expected_response = {
          status: 201,  
          message: 'success',
          data: {
            id: @user_data['id'],
            username: @user_data['username'],
            email: @user_data['email'],
            bio: @user_data['bio'],
            created_at: @user_data['created_at'],
          }
        }.to_json
          
        params = {
          'username' => @user_data['username'],
          'email' => @user_data['email'],
          'bio' => @user_data['bio'],
        }

        controller = UsersController.new
        response = controller.create(params)
        expect(response).to eq(expected_response)
      end
    end

    context 'when given invalid arguments' do
      it "should return status 400 when no username is given" do
        expected_response = {
          status: 400,  
          message: 'bad request',
        }.to_json
          
        params = {
          'email' => @user_data['email'],
          'bio' => @user_data['bio'],
        }

        controller = UsersController.new
        response = controller.create(params)
        expect(response).to eq(expected_response)
      end

      it "should return status 400 when no email is given" do
        expected_response = {
          status: 400,  
          message: 'bad request',
        }.to_json
          
        params = {
          'username' => @user_data['username'],
          'bio' => @user_data['bio'],
        }
    
        controller = UsersController.new
        response = controller.create(params)
        expect(response).to eq(expected_response)
      end

      it "should return status 400 bad request when username is empty string" do
        expected_response = {
          status: 400,  
          message: 'bad request',
        }.to_json
          
        params = {
          'username' => '',
          'email' => @user_data['email'],
          'bio' => @user_data['bio'],
        }

        controller = UsersController.new
        response = controller.create(params)
        expect(response).to eq(expected_response)
      end

      it "should return status 400 when email is an empty string" do
        expected_response = {
          status: 400,  
          message: 'bad request',
        }.to_json
          
        params = {
          'email' => '',
          'username' => @user_data['username'],
          'bio' => @user_data['bio'],
        }
    
        controller = UsersController.new
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
            id: @user_data['id'],
            username: @user_data['username'],
            email: @user_data['email'],
            bio: @user_data['bio'],
            created_at: @user_data['created_at'],
          }
        }.to_json
          
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
        }.to_json
          
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
        expected_response = {
          status: 200,  
          message: 'success',
          data: {
            id: @user_data['id'],
            username: @user_data['username'],
            email: @user_data['email'],
            bio: @user_data['bio'],
            created_at: @user_data['created_at'],
          }
        }.to_json
          
        params = @user_data['username']

        controller = UsersController.new
        response = controller.show_by_username(params)
        expect(response).to eq(expected_response)
      end
    end
  end
end


