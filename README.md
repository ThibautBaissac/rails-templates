# Rails Templates

Quickly generate rails app ready to be deployed with Bootstrap, Simple form and debugging gems based on the famous [Le Wagon](https://github.com/lewagon/rails-templates/) using [Rails Templates](http://guides.rubyonrails.org/rails_application_templates.html).


---
## Hotwire

Get a [**Hotwired**](https://github.com/hotwired/hotwire-rails) rails 6 app  **plus** a Devise installed with a generated User model.

```bash
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/ThibautBaissac/rails-templates/master/hotwire.rb \
  CHANGE_THIS_TO_YOUR_RAILS_APP_NAME
```

---
## Minimal
[**Original from Le Wagon**](https://github.com/lewagon/rails-templates/)

Get a minimal rails app ready to be deployed on Heroku with Bootstrap, Simple form and debugging gems.

```bash
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/lewagon/rails-templates/master/minimal.rb \
  CHANGE_THIS_TO_YOUR_RAILS_APP_NAME
```

---
## Devise
[**Original from Le Wagon**](https://github.com/lewagon/rails-templates/)

Same as minimal plus a Devise install with a generated User model.

```bash
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/lewagon/rails-templates/master/devise.rb \
  CHANGE_THIS_TO_YOUR_RAILS_APP_NAME
```
