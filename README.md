# Rails Templates

Quickly generate rails app ready to be deployed with Bootstrap, Simple form and debugging gems based on the famous [Le Wagon](https://github.com/lewagon/rails-templates/) using [Rails Templates](http://guides.rubyonrails.org/rails_application_templates.html).


***
## Rails 7 Full

Create a brand new **Rails 7** full app using esbuild (instead of Webpack), Devise, Bootstrap 5, Simple_form, i18n, Devise-i18n, Paggy, route_translator, meta-tags, service_actor, faker and rspec

1. Install Rails 7:
```bash
rails -v
gem install rails
```

2. Update node (npm 7.1+):
```bash
node -v
nvm install node
```

3. Create your new project:
```bash
rails new CHANGE_THIS_TO_YOUR_RAILS_APP_NAME -T \
  --database postgresql \
  -j esbuild --css bootstrap \
  -m https://raw.githubusercontent.com/ThibautBaissac/rails-templates/master/rails_7_full.rb
```

***
## Rails 7 with Devise

Create a brand new **Rails 7** app with Devise, Bootstrap 5 and esbuild.

1. Install Rails 7:
```bash
gem install rails
```

2. Create your new project:
```bash
rails new CHANGE_THIS_TO_YOUR_RAILS_APP_NAME \
  --database postgresql \
  -j esbuild --css bootstrap \
  -m https://raw.githubusercontent.com/ThibautBaissac/rails-templates/master/rails_7.rb
```

3. Start the application:
```bash
./bin/dev
```

---
## Rails 6 with Hotwire

Get a [**Hotwired**](https://github.com/hotwired/hotwire-rails) rails app  **plus**  Devise installed with a generated User model.

```bash
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/ThibautBaissac/rails-templates/master/hotwire.rb \
  CHANGE_THIS_TO_YOUR_RAILS_APP_NAME
```

---
## Le Wagon Original Templates
[**Original templates from Le Wagon**](https://github.com/lewagon/rails-templates/)
