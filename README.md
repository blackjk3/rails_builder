RailsBuilder
================
GUI add-on for managing migrations, routes, models, etc.

Disclaimer: This is still a proof of concept! Please use at your own risk.  Pull requests, feature enhancements would be much appreciated :)

Usage
================
In gemfile
```ruby
group :development do
  gem 'rails_builder', :git => 'git@github.com:blackjk3/rails_builder.git'
end
```

In routes.rb
```ruby
mount RailsBuilder::Engine => "/rails_builder"
```

Screenshot
================
![Migrations View](/img/screenie.png?raw=true "Migrations View")
![Routes View](/img/screenie2.png?raw=true "Routes View")