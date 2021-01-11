# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

#.envファイルでキーを管理
Refile.secret_key = ENV["CONFIG_REFILEKEY"]

Groupdate.time_zone = false
