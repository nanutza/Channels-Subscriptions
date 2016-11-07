def current_user
  User.find_by(id: session[:user_id])
end

def logged_in?
  !!current_user
end

def require_login
  redirect :'/login' unless logged_in?
end

def subscriber
  @channel.subscribers.find_by(id: current_user.id)
end

def subscribed?
  subscriber != nil
end
