helpers do
  def h_(text)
    Rack::Utils.escape(text)
  end

  def email(subject, body)
    Pony.mail({
      :to => params[:email],
      :via => :smtp,
      :subject => subject,
      :html_body => erb(body, layout: false),
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'dummytest3210@gmail.com',
        :password             => 'viewsonic123',
        :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain               => "heroku.com" # the HELO domain provided by the client to the server
      }
    })
  end
end
