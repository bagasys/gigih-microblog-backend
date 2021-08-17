require_relative '../db/connector.rb'

class Hashtag
  attr_accessor :name, :total_occurences
  def initialize(params)
    @name = params[:name]
    @total_occurences = params[:total_occurences]
  end

  

end