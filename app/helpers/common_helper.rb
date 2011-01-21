# encoding: utf-8
Haircut.helpers do
  def basic_auth!
    @@AUTH_MESSAGE = "input username and password"
    unless authorized_with_basic?(Rack::Auth::Basic::Request.new(request.env))
      response['WWW-Authenticate'] = %Q(Basic realm="#{@@AUTH_MESSAGE}")
      throw(:halt, [401, "Not Authorized.\n#{@@AUTH_MESSAGE}\n"])
    end
    true
  end
  
  private
    def authorized_with_basic?(auth)
      auth.provided? and auth.basic? and auth.credentials == Hc::Config[:basic_auth]
    end
  # end private
end
