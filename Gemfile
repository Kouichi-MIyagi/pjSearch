source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]

group :development do
  gem 'yaml_db'
  gem 'sqlite3'
  gem 'rack-mini-profiler'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'devise'

gem 'cancancan'

gem 'will_paginate'

#Use twitter-bootstrap3
gem 'bootstrap-sass', '~> 3.0.3.0'

# for passing some data from controller to javascript
gem 'gon'

gem 'carrierwave'
gem 'mini_magick'

# 一括インサート
gem 'activerecord-import'
# webserver
gem 'thin'
#ActiveRecordと同じように振る舞う、テーブル無しのモデルを扱う
gem 'active_attr'

# 検索
gem 'ransack'

# gem for Test
group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'simplecov'
end
