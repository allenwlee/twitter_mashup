get '/' do


  erb :index
end

get '/:username' do
  # Look in app/views/index.erb
  TwitterUser.create(screen_name: params[:username])
  @user = TwitterUser.find_by_screen_name(params[:username])
  if @user.tweets_stale?
    @user.fetch_tweets!
    erb :spinwheel
  else
    @top_tweets = @user.tweets
    erb :index
  end

end

post "/:username/get_tweets" do 
  @user = TwitterUser.find_by_screen_name(params[:username])
  @top_tweets = Twitter.user_timeline(@user.screen_name)[0..9]
  @user.tweets.destroy_all
  @top_tweets.each do |tweet|
    @user.tweets << Tweet.create(content: tweet[:text], creation_date: tweet[:created_at])
  end
  erb :_posts, :layout => false, :locals => {tweets: @user.tweets} 
end

get '/spinwheel' do
  erb :spinwheel
end
