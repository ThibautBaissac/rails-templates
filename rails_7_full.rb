run "if uname | grep -q 'Darwin'; then pgrep spring | xargs kill -9; fi"

# GEMFILE
########################################
inject_into_file 'Gemfile', before: 'group :development, :test do' do
  <<~RUBY
    gem 'devise', git: 'https://github.com/heartcombo/devise', branch: 'main'

    gem 'autoprefixer-rails', '10.2.5'
    gem 'simple_form'
    # gem 'font-awesome-sass', '~> 5.6.1'

    # https://github.com/tigrish/devise-i18n
    gem "devise-i18n"

    # https://guides.rubyonrails.org/i18n.html
    # gem "rails-i18n"

    #https://github.com/enriclluelles/route_translator
    # gem "route_translator", "~> 12.0"

    # https://github.com/ddnexus/pagy
    # https://ddnexus.github.io/pagy/how-to#quick-start&gsc.tab=0
    gem "pagy", "~> 5.6"

    # https://github.com/kpumuk/meta-tags/
    gem 'meta-tags'

    # https://github.com/sunny/actor
    gem 'service_actor'
    gem "service_actor-rails"

    gem 'faker'

    # Code coverage : https://github.com/simplecov-ruby/simplecov
    gem 'simplecov', require: false, group: :test

  RUBY
end

inject_into_file 'Gemfile', after: 'group :development, :test do' do
  <<-RUBY

  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'dotenv-rails'
  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 5.0.0'
  RUBY
end

inject_into_file 'Gemfile', after: 'group :development do' do
  <<-RUBY

  # https://github.com/BetterErrors/better_errors
  gem "better_errors"
  gem "binding_of_caller"
  RUBY
end

# Redis
gsub_file('Gemfile', /# gem "redis", "~> 4.0"/, "gem 'redis'")

# Assets
########################################
run 'rm -rf app/assets/stylesheets'
run 'curl -L https://github.com/lewagon/rails-stylesheets/archive/master.zip > stylesheets.zip'
run 'unzip stylesheets.zip -d app/assets && rm stylesheets.zip && mv app/assets/rails-stylesheets-master app/assets/stylesheets'
gsub_file('app/assets/stylesheets/application.scss', /@import "font-awesome-sprockets";/, "")
gsub_file('app/assets/stylesheets/application.scss', /@import "font-awesome";/, "")


# Dev environment
########################################
gsub_file('config/environments/development.rb', /config\.assets\.debug.*/, 'config.assets.debug = false')

# Flashes
########################################
file 'app/views/shared/_flashes.html.erb', <<~HTML
  <% if notice %>
    <div class="alert alert-info alert-dismissible fade show m-1" role="alert">
      <%= notice %>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
      </button>
    </div>
  <% end %>
  <% if alert %>
    <div class="alert alert-warning alert-dismissible fade show m-1" role="alert">
      <%= alert %>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
      </button>
    </div>
  <% end %>
HTML

# NAVBAR (BOOTSTRAP)
########################################
file 'app/views/shared/_navbar.html.erb', <<~HTML
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">Navbar</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Link</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Dropdown
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
              <li><a class="dropdown-item" href="#">Action</a></li>
              <li><a class="dropdown-item" href="#">Another action</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="#">Something else here</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
          </li>
        </ul>
        <form class="d-flex">
          <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success" type="submit">Search</button>
        </form>
      </div>
    </div>
  </nav>
HTML

inject_into_file 'app/views/layouts/application.html.erb', after: '<body>' do
  <<-HTML

    <%= render 'shared/navbar' %>
    <%= render 'shared/flashes' %>
  HTML
end

# README
########################################
markdown_file_content = <<-MARKDOWN
Rails 7 app generated with [thibautbaissac/rails-templates](https://github.com/thibautbaissac/rails-templates), based on the famous [Le Wagon](https://www.lewagon.com) devise template.
MARKDOWN
file 'README.md', markdown_file_content, force: true


########################################
# AFTER BUNDLE
########################################
after_bundle do
  # Generators: db + simple form + pages controller
  ########################################
  rails_command 'db:drop db:create db:migrate'
  rails_command 'turbo:install:redis'
  generate(:controller, 'pages', 'home', '--skip-routes', '--no-test-framework')
  generate('simple_form:install', '--bootstrap')
  generate('meta_tags:install')
  generate('rspec:install')
  run 'rm -f  app/assets/stylesheets/application.bootstrap.scss'

  # Routes
  ########################################
  inject_into_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do
    <<-RUBY

    scope '(:locale)', locale: /fr|en/ do
      root to: 'pages#home'
    end
    RUBY
  end

  # Git ignore
  ########################################
  append_file '.gitignore', <<~TXT
    # Ignore .env file containing credentials.
    .env*
    # Ignore Mac and Linux file system files
    *.swp
    .DS_Store
  TXT

  # Devise install + user
  ########################################
  generate('devise:install')
  generate('devise', 'User')
  # generate('-f devise:i18n:views')

  # App controller
  ########################################
  run 'rm app/controllers/application_controller.rb'
  file 'app/controllers/application_controller.rb', <<~RUBY
    class ApplicationController < ActionController::Base
    #{  "protect_from_forgery with: :exception\n" if Rails.version < "5.2"}  before_action :authenticate_user!
    end
  RUBY

  # I18N
  ########################################
  run 'curl -L https://raw.githubusercontent.com/ThibautBaissac/rails-templates/master/config/locales.zip > locales.zip'
  run 'unzip locales.zip -d config/locales && rm locales.zip'

  inject_into_file 'config/application.rb', after: 'class Application < Rails::Application' do
    <<-RUBY

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:fr, :en]
    config.i18n.default_locale = :fr
    RUBY
  end

  inject_into_file 'app/controllers/application_controller.rb', after: 'class ApplicationController < ActionController::Base' do
    <<-RUBY
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end
    RUBY
  end

  # PAGY
  ########################################
  run 'curl -L https://raw.githubusercontent.com/ThibautBaissac/rails-templates/master/config/pagy.rb > config/initializers/pagy.rb'
  inject_into_file 'app/controllers/application_controller.rb', after: 'class ApplicationController < ActionController::Base' do
  <<-RUBY

  include Pagy::Backend
  RUBY
  end

  # migrate + devise views
  ########################################
  rails_command 'db:migrate'
  generate('devise:views')

  # Pages Controller
  ########################################
  run 'rm app/controllers/pages_controller.rb'
  file 'app/controllers/pages_controller.rb', <<~RUBY
    class PagesController < ApplicationController
      skip_before_action :authenticate_user!, only: [ :home ]

      def home
      end
    end
  RUBY

  #Rspec
  ########################################
  append_file '.rspec', <<~TXT
    --format documentation
  TXT

  prepend_file 'spec/spec_helper.rb', <<~RUBY
    require 'simplecov'
    SimpleCov.start
  RUBY


  # Package
  ########################################
  script = <<~JSON
  ,
    "scripts": {
      "build": "esbuild app/javascript/*.* --bundle --outdir=app/assets/builds",
      "build:css": "sass ./app/assets/stylesheets/application.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules"
    }
  }
  JSON
  gsub_file('package.json', /.*\K}/m, script)

  # Environments
  ########################################
  environment 'config.action_mailer.default_url_options = { host: "http://localhost:3000" }', env: 'development'
  environment 'config.action_mailer.default_url_options = { host: "http://TODO_PUT_YOUR_DOMAIN_HERE" }', env: 'production'

  # Dotenv
  ########################################
  run 'touch .env'

  # Rubocop
  ########################################
  run 'curl -L https://raw.githubusercontent.com/ThibautBaissac/rails-templates/master/config/.rubocop.yml > .rubocop.yml'

  # Git
  ########################################
  git add: '.'
  git commit: "-m 'Initial commit with template from https://github.com/ThibautBaissac/rails-templates'"
end
