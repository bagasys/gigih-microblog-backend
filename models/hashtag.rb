require_relative '../db/connector.rb'

class Hashtag
  attr_accessor :name, :total_occurences
  def initialize(params)
    @name = params[:name]
    @total_occurences = params[:total_occurences]
  end

  def self.extract_hashtags_from_text(text)
    text.scan(/#[a-zA-Z]+/)
  end

  def self.save_hashtags_from_post(text, post_id)
    client = create_db_client

    hashtags = text.scan(/#[a-zA-Z]+/)

    if !hashtags.empty?
      query_text = "INSERT INTO hashtags (post_id, name) VALUES "
      hashtags.each_with_index do |hashtag, index|
        if index != 0
          query_text += ", "  
        end
        query_text += "(#{post_id}, '#{hashtag}')"
      end
      client.query(query_text)
    end
  end
  

end