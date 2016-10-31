get '/channels'  do
	@channels = Channel.all
	erb :'channels/index'
end

get '/channels/:id' do
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

post '/channels/:id' do
    erb :'404'
  # redirect "/channels/#{channel.id}"
end
