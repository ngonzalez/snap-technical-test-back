# snap-technical-test

* Configure application
The application uses [`dotenv`](https://github.com/bkeepers/dotenv) to load configuration.
Please create the `.env` file from the sample file.
```shell
cp .env.sample .env
```

* Install bundle dependencies
```shell
bundle install
```

* Install yarn dependencies
```shell
yarn install
```

* Database creation
```shell
bundle exec rails db:create
```

* Database initialization
```shell
bundle exec rails db:migrate
```

* Seed database
```shell
bundle exec rails db:seed
```

* Precompile assets
```shell
bundle exec rails assets:precompile
```

* Webpack compile assets
```shell
bundle exec rails webpacker:compile
```

* Start development server
```shell
bundle exec rails s -p 3000
```

* Launch browser
```
http://127.0.0.1:3000
```

* Start Sidekiq
```
bundle exec sidekiq -e development
```
