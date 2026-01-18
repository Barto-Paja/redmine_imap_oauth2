require 'base64'

module RedmineImapOauth2
  class Xoauth2
    def self.build(email, token)
      str = "user=#{email}\x01auth=Bearer #{token}\x01\x01"
      Base64.strict_encode64(str)
    end
  end
end
