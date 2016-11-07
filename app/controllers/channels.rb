get '/channels'  do
	@channels = Channel.all
	erb :'channels/index'
end

before '/channels/:id*' do
  require_login
end

get '/channels/:id' do
  @channel = Channel.find_by(id: params[:id])
  subscribers = @channel.subscribers
  erb :'channels/show'
end

post '/channels/:id/subscriptions' do
  @channel = Channel.find_by(id: params[:id])
  @subscription = Subscription.new(user: current_user, channel: @channel)

  if @subscription.save
      redirect "/channels/#{@channel.id}"
  else
      @errors = subscription.errors.full_messages
      erb :'/channels/index'
  end
end

delete '/channels/:id/subscriptions' do
	if current_user.channels.delete(Channel.find(params[:id]))
    redirect "/channels/#{params[:id]}"
  else
    @errors = subscription.errors.full_messages
    erb :'/channels/index'
  end
end
