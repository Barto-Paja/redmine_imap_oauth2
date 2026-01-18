Redmine::Plugin.register :redmine_imap_oauth2 do
  name 'Redmine IMAP OAuth2'
  author 'Bartosz Pajewski'
  version '0.1.0'
end

Rails.configuration.to_prepare do
  require_dependency 'redmine_imap_oauth2/imap_patch'
end
