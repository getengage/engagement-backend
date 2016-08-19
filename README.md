<h1 align="center"><br>Engagement<br></h1>
<h4 align="center">Metrics and Analytics</h4>

<p align="center">
</p>
<br>

This is the home for the Engagement backend

#### Features

- add
- more
- stuff

#### Inspiration

- fonts: http://defharo.com/dise%C3%B1o-grafico/tipografia/monserga-outline-round-font/
- goworkers: http://mildlyinternet.com/code/supercharge-resque-and-sidekiq-with-go-part-2.html

#### Todo

- add
- more
- stuff

#### Dependencies & Setup

###### Dependencies

```unix
  brew install pg
  brew install redis
  brew install influxdb

  powder link api.engage
  touch .powenv
  rvm env -- 2.2.3@engagement > .powenv

  brew install go
  export GOPATH=/path_to_go
  go get github.com/benmanns/goworker
  go get github.com/xlvector/hector
  go install github.com/xlvector/hector/hectorcv
```

###### Setup

```ruby
  rake db:create db:migrate
  rake data:migrate
  rake db:seed
```

###### Debugging

```unix
  toggle server config in development.rb
  powder stop
  powder start
  add `byebug` to line in code
  bundle exec byebug -R localhost:1048
  hit api endpoint with `byebug` line
```

#### License

Copyright (c) [Nick Soto](http://google.com)
