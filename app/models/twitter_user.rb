class TwitterUser < ActiveRecord::Base

  has_many :tweets

  def tweets_stale?
    return true if self.tweets.empty?
    tweet_frequency = []

    self.tweets.each_with_index do |tweet, i|
      break if i == (self.tweets.length - 1)
      diff = (DateTime.parse(tweet.creation_date) - DateTime.parse(self.tweets[i + 1].creation_date))
      tweet_frequency << diff.to_f
    end
    average_time = (tweet_frequency.inject{|element, acc| acc+= element}/self.tweets.length ) * 24 * 60

    last_tweet = self.tweets.first
    time_difference = (DateTime.now - DateTime.parse(last_tweet.created_at.to_s))
      minutes = (time_difference * 24 * 60).to_i
      return minutes >= average_time ? true : false
    end

    def fetch_tweets!
      @top_tweets = Twitter.user_timeline(self.screen_name)[0..9]
      self.tweets.destroy_all
      @top_tweets.each do |tweet|
        self.tweets << Tweet.create(content: tweet[:text], creation_date: tweet[:created_at])
      end
    end

  end
