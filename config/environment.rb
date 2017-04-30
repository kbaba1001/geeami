require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/geeami'
require_relative '../apps/web/application'

Hanami.configure do
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/geeami_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/geeami_development'
    #    adapter :sql, 'mysql://localhost/geeami_development'
    #
    adapter :sql, "postgresql://postgres:@db/geeami_#{ENV['HANAMI_ENV']}"

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/geeami/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json

    mailer do
      delivery :smtp, address: ENV['SMTP_HOST'], port: ENV['SMTP_PORT']
    end
  end
end
