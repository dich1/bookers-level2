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
rails g devise:views

devise_create_users.rb
t.string :name
t.string :image
t.string :introduction
t.integer :profile_image_id

rails db:migrate

rails g model Book user_id:integer title:string body:string

rails g controller homes index about
rails g controller books index show create edit update destroy
rails g controller users index show edit update

config/routes.rb
root 'homes#index'
resources :books

rails db:migrate

Gemfile
gem 'dotenv-rails'
group :production do
  gem 'mysql2'
end

bundle install --without production

.env
touch env.txt
mv env.txt .env
DB_USERNAME="RDSの接続ユーザ名"
DB_PASSWORD="RDSのパスワード"
DB_HOST="RDSのエンドポイント名"
DB_DATABASE="アプリケーション名"

.gitignore
sed -ie '$a /.env' .gitignore

config/database.yml
production:
  <<: *default
  database: <%= ENV['DB_DATABASE'] %>
  adapter: mysql2
  encoding: utf8mb4
  charset: utf8mb4
  collation: utf8mb4_general_ci
  host: <%= ENV['DB_HOST'] %>
  username: <%= ENV['DB_USERNAME'] %>
  password: <%= ENV['DB_PASSWORD'] %>
  
config/puma.rb
bind "unix://#{Rails.root}/tmp/sockets/puma.sock"
rails_root = Dir.pwd
# 本番環境のみデーモン起動
if Rails.env.production?
  pidfile File.join(rails_root, 'tmp', 'pids', 'puma.pid')
  state_path File.join(rails_root, 'tmp', 'pids', 'puma.state')
  stdout_redirect(
    File.join(rails_root, 'log', 'puma.log'),
    File.join(rails_root, 'log', 'puma-error.log'),
    true
  )
  # デーモン
  daemonize
end

git add Gemfile Gemfile.lock config/puma.rb config/database.yml .gitignore
git commit -m 'deploy setting'
git push origin main

ssh -i ~/.ssh/xxxx.pem ec2-user@xx.xxx.xx.xxx 
sudo yum update
sudo amazon-linux-extras install nginx1
sudo chkconfig nginx on
sudo service nginx start
 sudo sh -c "echo 'Hello World' > /usr/share/nginx/html/index.html"
 
sudo yum -y install libpng-devel libjpeg-devel libtiff-devel gcc
wget http://www.imagemagick.org/download/ImageMagick.tar.gz
tar -vxf ImageMagick.tar.gz
cd ImageMagick-x.x.x-xx
./configure
make
sudo make install

sudo yum remove -y ruby*
sudo yum -y install gcc-c++ git openssl-devel readline-devel

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
sudo ~/.rbenv/plugins/ruby-build/install.sh
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
rbenv install 2.6.3
rbenv global 2.6.3
rbenv rehash
rbenv exec gem install bundler
bundle -v

sudo yum -y install patch libyaml-devel zlib zlib-devel libffi-devel make autoconf automake libcurl-devel sqlite-devel mysql-devel
curl --silent --location https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum install -y nodejs
gem install rails -v 5.2.4
rails -v

bundle install --path vendor/bundle --without test development
bundle exec rails assets:precompile RAILS_ENV=production
bundle exec rails db:create RAILS_ENV=production
bundle exec rails db:migrate RAILS_ENV=production

sudo vi /etc/nginx/nginx.conf
sudo touch /etc/nginx/conf.d/bookers-level2.conf
sudo cat <<EOL >> /etc/nginx/conf.d/bookers-level2.conf
upstream puma {
    server unix:///home/ec2-user/bookers-level2/tmp/sockets/puma.sock;
}
server {
    listen       80;
    server_name  52.195.11.254;
    root /home/ec2-user/bookers-leveel2/public;
    access_log  /var/log/nginx/access.log  main;
    error_log /var/log/nginx/error.log;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on; 
    keepalive_timeout   65;
    types_hash_max_size 2048;
    client_max_body_size 100M;
    include             /etc/nginx/mime.types;

    location / {
        proxy_pass http://puma;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_redirect off;
        proxy_connect_timeout 30;
    }

    location ^~ /assets/ {
        gzip_static on;
        expires max;
        add_header Cache-Control public;
        root /home/ec2-user/bookers-level2/public;
    }
}
EOL

sudo chown -R ec2-user /var/lib/nginx

puma.sh
#!/bin/bash
DIR="/home/ec2-user/booker-level2"
cd $DIR

scp -i ~/.ssh/practice-aws.pem ~/.ssh/id_rsa.pub ec2-user@ipアドレス:.ssh/id_rsa.pub

scp -i ~/.ssh/practice-aws.pem ~/.ssh/id_rsa.pub ec2-user@52.195.11.254:.ssh/id_rsa.pub
scp -i ~/.ssh/practice-aws.pem puma.sh ec2-user@52.195.11.254:/home/ec2-user

crontab -e
@reboot /bin/bash --login /home/ec2-user/puma.sh >> /home/ec2-user/cron.log

bundle exec rails s -e production >> puma.log &

HOST_NAME : EC2のパブリックIPアドレスの指定
USER_NAME：ec2-user
PRIVATE_KEY：EC2上かCloud9上に存在する~/.ssh/id_rsaの値

https://github.com/dich1/bookers-level2/settings/secrets/new

cat ~/.ssh/id_rsa
```