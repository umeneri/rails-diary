# Getting Started

$ docker-compose build
$ docker-compose run --rm web rake db:create
$ docker-compose run --rm web rails db:migrate
$ docker-compose up -d
$ open http://localhost:3000

# Scaffolding


# Deploying
$ heroku login
$ heroku container:login
$ heroku addons:create heroku-mysql:hobby-dev
$ heroku create
$ heroku container:push web
$ heroku open

# Initialization
$ docker-compose run --rm web rails new . --force --database=mysql --skip-bundle


