# Rails Templates

Quickly generate rails app ready to be deployed with Bootstrap, Simple form and debugging gems based on the famous [Le Wagon](https://github.com/lewagon/rails-templates/) using [Rails Templates](http://guides.rubyonrails.org/rails_application_templates.html).


***
## Rails 7

Create a brand new **Rails 7** app with Devise, Bootstrap 5 and esbuild.

1. Install Rails 7:
```bash
gem install rails --no-document --pre
```

2. Create your new project:
```bash
rails _7.0.0.rc1_ new CHANGE_THIS_TO_YOUR_RAILS_APP_NAME \
  --database postgresql \
  -j esbuild --css bootstrap \
  -m /Users/thibautbaissac/code/ThibautBaissac/rails-templates/rails_7.rb
```

3. Start the application:
```bash
./bin/dev
```

---
## Hotwire

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
