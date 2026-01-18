require 'net/imap'
require 'redmine_imap_oauth2/ms_token'
require 'redmine_imap_oauth2/xoauth2'

module RedmineImapOauth2
  module ImapPatch
    def self.apply(imap, settings)
      return unless settings[:auth_method] == 'xoauth2'
      return unless settings[:provider] == 'microsoft'

      token = MicrosoftToken.fetch(settings)
      xoauth2 = Xoauth2.build(settings[:username], token)

      imap.authenticate('XOAUTH2', settings[:username], xoauth2)
    end
  end
end

# monkey patch rake task
module Net
  class IMAP
    alias_method :original_login, :login

    def login(user, password)
      if password == '__OAUTH2__'
        settings = Redmine::Configuration['imap_oauth2']
        RedmineImapOauth2::ImapPatch.apply(self, settings)
      else
        original_login(user, password)
      end
    end
  end
end
