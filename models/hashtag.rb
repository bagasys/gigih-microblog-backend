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

  

end