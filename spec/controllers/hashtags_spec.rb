require_relative '../../controllers/hashtags.rb'
require 'json'

describe HashtagsController do

  describe 'show_trending_hashtags' do
    it 'should response with the data in array form and status code 200' do
      expected_response = {
        status: 200,  
        message: 'success',
        data:[{
          name: '#gagah',
          total_occurences: 100
        }]
      }.to_json

      controller = HashtagsController.new
      response = controller.show_trending_hashtags()
      
      expect(response).to eq(expected_response)
    end
  end

end