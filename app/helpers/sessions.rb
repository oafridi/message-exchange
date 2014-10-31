helpers do

  def logged_in?
    return true if session[:user_id]
    false
  end

end
