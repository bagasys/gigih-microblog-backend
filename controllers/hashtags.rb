require './models/post'
require './models/hashtag'
require "sinatra"

class HashtagsController
  def show_trending_hashtags()
    hashtags = Hashtag::find_trendings()

    data = []
    hashtags.each do |hashtag|
      data << {name: hashtag.name, total_occurences: hashtag.total_occurences}
    end

    return ({
      status: 200,
      message: "success",
      data: data
    })
  end
end