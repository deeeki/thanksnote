Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Figaro.env.facebook_app_id, Figaro.env.facebook_app_secret,
    scope: 'email,xmpp_login'
end

OmniAuth.config.on_failure = lambda do |env|
  message = CGI.escape(env['omniauth.error.type'].to_s.humanize)
  new_path = "/auth/failure?message=#{message}&#{env['QUERY_STRING']}"
  [302, {'Location' => new_path}, []]
end
