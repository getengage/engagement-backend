<h1 align="center">Engagement<br></h1>
<h4 align="center">Metrics and Analytics</h4>

<p align="center">
  <a href="https://circleci.com/gh/nicksoto/engagement-backend"><img src="https://circleci.com/gh/nicksoto/engagement-backend.png?style=shield&circle-token=13e8f29fdd7502e8466f98ae36fd6f4624ba49c7"></a>
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
  brew install node
  brew install go

  powder link api.engage
  touch .powenv
  rvm env -- 2.2.3@engagement > .powenv

  export GOPATH=/path_to_go
  go get github.com/benmanns/goworker
  go get github.com/xlvector/hector
  go get github.com/xlvector/hector/hectorcv

```

don't use rails server for local development, use:

```unix
  npm run postinstall (if first install or devdependencies change)
  npm run rails-server
```

this uses webpack to rebuild the app/assets/web-bundle.js file w/ react components.

react is a dependency so get [react developer tools for chrome](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi/related)

###### Setup

```ruby
  rake db:create db:migrate
  rake data:migrate
  rake db:seed
```

###### Debugging

```unix
  powder restart
  add `byebug` to line in code
  bundle exec byebug -R localhost:1048
  hit api endpoint with `byebug` line
```

#### License

Copyright (c) [Nick Soto](http://google.com)
