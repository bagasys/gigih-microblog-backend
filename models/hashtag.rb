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

    client.close
    return true
  end

  def self.find_trendings
    client = create_db_client

    rows = client.query('SELECT name, COUNT(id) as total_occurences FROM hashtags WHERE created_at > (NOW() - INTERVAL 1 DAY)  GROUP BY name ORDER BY count(id) DESC')
    
    hashtags = []
    rows.each do |row|
      hashtag = Hashtag.new(name: row['name'], total_occurences: row['total_occurences'])
      hashtags << hashtag
    end

    client.close

    hashtags
  end
end