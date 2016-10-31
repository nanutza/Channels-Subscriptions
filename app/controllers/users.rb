get '/users' do
  erb :index
end

get '/users/new' do
  erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save && params[:user][:password] == params[:password_confirmation]
    status 200
    session[:user_id] = @user.id
    redirect '/users'
  else
    status 500
    @errors = @user.errors.full_messages
    erb :'users/new'
  end
end

get '/login' do
  erb :'/sessions/_login'
end

post '/login' do
  user = User.find_by_email(params[:user][:email])
  if user && user.authenticate(params[:user][:password])
    status 200
    session[:user_id] = user.id
    redirect '/'
  else
    status 500
    @errors = ["incorrect email or password"]
    erb :'/sessions/_login'
  end
end


get '/users/:id' do
  require_login
  @user = User.find_by(id: params[:id])
  if current_user.id == @user.id
    @channels = @user.channels.order(:name)
    erb :'/users/show'
  else
    erb :'error_404'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end
