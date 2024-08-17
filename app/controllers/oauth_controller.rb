class OauthController < ApplicationController

  # to initiate the login process,
  # We will redirect the user to Keycloak with the parameter: redirect_uri
  # the user will be redirected to keycloak, and upon success redirected back to the application
  def new
    port_str = [80, 443].include?(request.port.to_i) ? "" : ":" + request.port.to_s
    redirect_uri = "#{request.scheme}://#{request.host}#{port_str}/oauth/keycloak/callback"
    redirect_uri_escaped = CGI.escape(redirect_uri)
    client_id =  ENV.fetch("KEYCLOAK_CLIENT_ID", "dummy-client")
    realm = ENV.fetch("KEYCLOAK_REALM", "dummy" )
    auth_server_url = ENV.fetch("KEYCLOAK_AUTH_SERVER_URL", "http://localhost:8080" )
    to = "#{auth_server_url}/realms/#{realm}/protocol/openid-connect/auth?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri_escaped}&login=true&scope=openid"
    redirect_to to, allow_other_host: true
  end

  # callback from keycloak
  # the user is redirected back from keycloak
  def create
    current_user = User.find_or_create_by(id: auth_hash.extra.raw_info.sub, email: auth_hash.info.email, first_name: auth_hash.info.first_name, last_name: auth_hash.info.last_name)

    session[:current_user_id] = current_user.id
    redirect_to projects_path
  end

  protected

  def auth_hash
    auth = request.env["omniauth.auth"]
    raise 'NotAuthenticatedError' unless auth

    auth
  end
end

