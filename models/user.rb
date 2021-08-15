class User
  attr_accessor :username, :email, :bio
  attr_reader :id, :created_at

  def initialize(params)
    @id = params[:id]
    @username = params[:username]
    @email = params[:email]
    @bio = params[:bio]
    @created_at = params[:created_at]
  end
end