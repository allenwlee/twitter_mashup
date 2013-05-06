get '/' do

  erb :index
end

get '/:username' do
  # Look in app/views/index.erb
  @user = TwitterUser.find_by_screen_name(params[:username])
  if @user.tweets_stale?
    @user.fetch_tweets!
  end
  @top_tweets = @user.tweets
  erb :index
end
