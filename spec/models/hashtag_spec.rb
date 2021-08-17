require_relative '../../models/hashtag.rb'

describe Hashtag do
  describe 'initialize' do
    context 'given all the arguments'
    before :each do
      @hashtag_data = {name: '#gigih', total_occurences: 10}
      @hashtag = Hashtag.new(
        name: @hashtag_data[:name], 
        total_occurences: @hashtag_data[:total_occurences]
      )
    end
    it 'should set name attribute' do
      expect(@hashtag.name).to be(@hashtag_data[:name])
    end

    it 'should set total_occurance' do
      expect(@hashtag.total_occurences).to be(@hashtag_data[:total_occurences])
    end
  end
end