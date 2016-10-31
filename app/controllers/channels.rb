get '/channels'  do
	@channels = Channel.all
	erb :'channels/index'
end
