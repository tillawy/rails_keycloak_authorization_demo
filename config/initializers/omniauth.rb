Rails.application.config.middleware.use OmniAuth::Builder do
  provider :keycloak_openid, ENV.fetch("KEYCLOAK_AUTH_CLIENT_ID", "dummy-client"),
  ENV.fetch("KEYCLOAK_AUTH_CLIENT_SECRET", "dummy-client-super-secret-xxx"),
  client_options: {
    site: ENV.fetch("KEYCLOAK_SERVER_URL", "http://localhost:8080"),
    realm: ENV.fetch("KEYCLOAK_AUTH_CLIENT_REALM_NAME", "dummy"),
    raise_on_failure: true,
    base_url: ""
  },
  name: "keycloak",
  provider_ignores_state: true
end

OmniAuth.config.logger = Rails.logger

OmniAuth.config.path_prefix = ENV.fetch("KEYCLOAK_AUTH_SERVER_PATH_PREFIX", "/oauth")

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if Rails.env.development?
