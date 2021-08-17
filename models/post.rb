require_relative '../db/connector.rb'
require_relative './hashtag.rb'

class Post
  attr_accessor :text_content, :attachment
  attr_reader :id, :user_id, :parent_id, :created_at 

  def initialize(params)
    @id = params[:id]
    @parent_id = params[:parent_id]
    @user_id = params[:user_id]
    @text_content = params[:text_content]
    @attachment = params[:attachment]
    @created_at = params[:created_at]
  end

  def valid?
    return false if @text_content == nil || @text_content == ''
    return true
  end

  def save    
    return false unless self.valid?
    
    client = create_db_client
    
    if !@parent_id.nil? && !@attachment.nil?
      client.query("INSERT INTO posts (user_id, text_content, parent_id, attachment) VALUES ('#{@user_id}', '#{@text_content}', #{@parent_id}, '#{@attachment}')")
    elsif !@parent_id.nil?
      client.query("INSERT INTO posts (user_id, text_content, parent_id) VALUES (#{@user_id}, '#{@text_content}', '#{@parent_id}')")
    elsif !@attachment.nil?
      client.query("INSERT INTO posts (user_id, text_content, attachment) VALUES (#{@user_id}, '#{@text_content}', '#{@attachment}')")
    else
      client.query("INSERT INTO posts (user_id, text_content) VALUES ('#{@user_id}', '#{@text_content}')")
    end

    id = client.last_id
    rows = client.query(
      "SELECT * FROM posts WHERE id=#{id}"
    )

    client.close()

    rows.each do |row|
      @id = row["id"]
      @created_at = row['created_at']
      break
    end

    return true
  end

  def self.find_by_id(id)
    client = create_db_client
    rows = client.query("SELECT * FROM posts WHERE id = #{id}")
    client.close
    post = nil
    rows.each do |row|
      post = Post.new({
        id: row["id"],
        parent_id: row["parent_id"],
        user_id: row["user_id"],
        text_content: row["text_content"],
        attachment: row["attachment"],
        created_at: row["created_at"]
      })
      break
    end
    post
  end

  def self.find_all
    client = create_db_client
    client.close
  end

 

end