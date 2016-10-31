get '/channels'  do
	@channels = Channel.all
	erb :'channels/index'
end

get '/channels/:id' do
	require_login
  @channel = Channel.find_by(id: params[:id])
  subscribers = @channel.subscribers
  subscribers.each do |subscriber|
    if current_user && subscriber.id == current_user.id
      @subscribed = true
    else
      @subscribed = false
    end
  end
  erb :'channels/show'
end

put '/channels/:id/subscriptions' do
  @channel = Channel.find_by(id: params[:id])
  @subscription = Subscription.new(user: current_user, channel_id: params[:id])

  if @subscription.save!
      @channel.subscriptions << @subscription
      @channel.save
      @channel
      @unsubscribe = true
      redirect "/channels/#{@channel.id}"
  else
      @errors = subscription.errors.full_messages
      erb :'/channels/index'
  end
end

delete '/channels/:id/subscriptions/:id' do
  @channel = Channel.find_by_id(params[:channel_id])
  @subscription = Subscription.where(channel: @channel, user: current_user  )
  if Subscription.destroy(@subscription)
      erb :'/channels/index'
  else
    @errors = subscription.errors.full_messages
    erb :'/channels/index'
  end
end
