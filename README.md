# README

```
rails new bookers-level2
cd bookers-level2

Gemfile
gem 'devise'
gem "refile", require: "refile/rails", github: 'manfe/refile'
gem "refile-mini_magick"
gem "bootstrap-sass"

group :test do
  gem 'capybara', '>= 2.15'
  gem 'rspec-rails'
  gem "factory_bot_rails"
  gem 'faker'
end

config/environments/test.rb
config.active_support.deprecation = :silence

bundle install

rails db:migrate RAILS_ENV=test
bundle exec rspec spec/ --format documentation -o rspec.log

echo "# bookers-level2" >> README.md
git init
git add README.md
git commit -m "環境構築"
git branch -M main
git remote add origin https://github.com/dich1/bookers-level2.git
git push -u origin main

rails g devise:install
rails g devise User
rails db:migrate

devise_create_users.rb
t.string :name
t.string :image
t.string :introduction
t.integer :profile_image_id

rails db:migrate

rails g model Book user_id:string title:string body:string

rails g controller home index about
rails g controller books index show create edit update destroy

config/routes.rb
root 'homes#index'
resources :books

rails db:migrate
```