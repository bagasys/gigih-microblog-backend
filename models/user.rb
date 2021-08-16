require_relative '../db/connector.rb'

class User
  attr_accessor :username, :email, :bio
  attr_reader :id, :created_at

  def initialize(params)
    @id = params[:id]
    @username = params[:username]
    @email = params[:email]
    @bio = params[:bio] ? params[:bio] : ''
    @created_at = params[:created_at]
  end

  def valid?
    return false if @username == nil || @username == ''
    return false if @email == nil || @email == ''
    return false if @bio == nil
    
    true
  end

  def save    
    client = create_db_client
    client.query(
      "INSERT INTO users (username, email, bio) VALUES ('#{@username}', '#{@email}', '#{@bio}')"
    )
    id = client.last_id
    rows = client.query(
      "SELECT * FROM users WHERE id=#{id}"
    )
    rows.each do |row|
      @id = row["id"]
      @created_at = row['created_at']
      break
    end

    true
  end


end