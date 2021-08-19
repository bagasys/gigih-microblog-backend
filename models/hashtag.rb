require_relative '../db/connector.rb'

class Hashtag
  attr_accessor :name, :total_occurences
  def initialize(params)
    @name = params[:name]
    @total_occurences = params[:total_occurences]
  end

  def self.find_trendings
    client = create_db_client

    rows = client.query('SELECT name, COUNT(id) as total_occurences FROM hashtags WHERE created_at > (NOW() - INTERVAL 1 DAY)  GROUP BY name ORDER BY count(id) DESC LIMIT 5')
    hashtags = []
    rows.each do |row|
      hashtag = Hashtag.new(name: row['name'], total_occurences: row['total_occurences'])
      hashtags << hashtag
    end

    client.close

    hashtags
  end
end