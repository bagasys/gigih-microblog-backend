require_relative '../../models/hashtag.rb'

describe Hashtag do
  before :each do
    @client = double
    allow(@client).to receive(:close)
    allow(Mysql2::Client).to receive(:new).and_return(@client)
  end
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

  describe 'extract_hashtags_from_text' do
    it 'should return all the hashtags exists in text' do
      hashtags = Hashtag::extract_hashtags_from_text('Halo #GIGIH #HeHe Oke.')
      expect(hashtags).to eq(['#GIGIH', '#HeHe'])
    end
  end
end