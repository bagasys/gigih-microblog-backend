require_relative '../db/connector.rb'

class Post
  attr_accessor :text_content, :attachment
  attr_reader :id, :user_id, :created_at 

  def initialize(params)
    @id = params[:id]
    @user_id = params[:user_id]
    @text_content = params[:text_content]
    @attachment = params[:attachment]
    @created_at = params[:created_at]
  end

  def valid?
    
  end

end