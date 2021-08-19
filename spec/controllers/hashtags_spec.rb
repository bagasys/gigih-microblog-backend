require_relative '../../controllers/hashtags.rb'
require 'json'
require "sinatra/namespace"

describe HashtagsController do
  before :each do
    @hashtag_data = {
      'name'=> "#gagah", 
      'total_occurences'=> 100, 
    }

    @hashtag = double

    allow(@hashtag).to receive(:name).and_return(@hashtag_data["name"])
    allow(@hashtag).to receive(:total_occurences).and_return(@hashtag_data["total_occurences"])
    
    allow(Hashtag).to receive(:find_trendings).and_return([@hashtag])

  end
  describe 'show_trending_hashtags' do
    it 'should response with the data in array form and status code 200' do
      expected_response = {
        status: 200,  
        message: 'success',
        data:[{name: @hashtag.name, total_occurences: @hashtag.total_occurences}]
      }

      controller = HashtagsController.new
      response = controller.show_trending_hashtags()
      
      expect(response).to eq(expected_response)
    end
  end

end