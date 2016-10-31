get '/channels'  do
	@channels = Channel.all
	erb :'channels/index'
end

get '/channels/:id' do
	require_login
  @channel = Channel.find_by(id: params[:id])
  subscribers = @channel.subscribers
  erb :'channels/show'
end

put '/channels/:id/subscriptions' do
	require_login
  @channel = Channel.find_by(id: params[:id])
  @subscription = Subscription.new(user: current_user, channel: @channel)

  if @subscription.save!
      @channel.subscriptions << @subscription
      redirect "/channels/#{@channel.id}"
  else
      @errors = subscription.errors.full_messages
      erb :'/channels/index'
  end
end

delete '/channels/:id/subscriptions' do
	require_login
	if current_user.channels.delete(Channel.find(params[:id]))
    redirect "/channels/#{params[:id]}"
  else
    @errors = subscription.errors.full_messages
    erb :'/channels/index'
  end
end
