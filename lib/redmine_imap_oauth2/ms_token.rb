require 'oauth2'

module RedmineImapOauth2
  class MicrosoftToken
    def self.fetch(cfg)
      client = OAuth2::Client.new(
        cfg[:client_id],
        cfg[:client_secret],
        site: "https://login.microsoftonline.com/#{cfg[:tenant_id]}",
        token_url: "/oauth2/v2.0/token"
      )

      token = client.client_credentials.get_token(
        scope: "https://outlook.office365.com/.default"
      )

      token.token
    end
  end
end
