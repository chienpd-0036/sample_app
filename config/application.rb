require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.load_defaults 5.2
    config.before_configuration do
      env_file = File.join Rails.root, "config", "application.yml"
      YAML.load(File.open(env_file)).each do |key, value|
      ENV[key.to_s] = value
      end if File.exists? env_file
    end
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
