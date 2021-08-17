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

    it 'should return empty array when there is no hashtag in the text.' do
      hashtags = Hashtag::extract_hashtags_from_text('Halo GIGIH HeHe Oke.')
      expect(hashtags).to eq([])
    end
  end

  describe 'save_hashtags_from_post' do
    before :each do
      @text_content = "Halo #GIGIH #HeHe Oke."
      @post_id = 2
      @extracted_tags = ["#GIGIH", "#HeHe"]
      allow(Hashtag).to receive(:extract_hashtags_from_text).with(@text_content).and_return(@extracted_tags)

      @query = "INSERT INTO hashtags (post_id, name) VALUES (#{@post_id}, '#{@extracted_tags[0]}'), (#{@post_id}, '#{@extracted_tags[1]}')"
      
      allow(@client).to receive(:query).with(@query)
    end
    it 'should execute the right query according to the argument given' do
      expect(@client).to receive(:query).with(@query)
      Hashtag::save_hashtags_from_post(@text_content, @post_id)
    end

    it 'should not execute any query if the text given contains no hashtag.' do
      expect(@client).not_to receive(:query)
      Hashtag::save_hashtags_from_post("Babibu Haha GIGIH", @post_id)
    end

    it 'should close the db connection.' do
      expect(@client).to receive(:close)
      Hashtag::save_hashtags_from_post(@text_content, @post_id)
    end

    
  end
end