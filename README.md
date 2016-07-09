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
  rvm env -- 2.2.3@engagement > .powenv
```

###### Setup

```ruby
rake db:setup
```

###### Debugging

```unix
  add `byebug` to line in code
  bundle exec byebug -R localhost:1048
  hit api endpoint with `byebug` line
```

#### License

Copyright (c) [Nick Soto](http://google.com)
