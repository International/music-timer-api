class ContextStore
  include Singleton

  def session_token
    Thread.current[:session_token]
  end

  def session_token=(value)
    Thread.current[:session_token] = value
  end

  def current_session
    Session.where( token: session_token ).first
  end

end
