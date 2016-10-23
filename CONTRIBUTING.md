<h1 align="center">Engagement<br></h1>
<h4 align="center">Contributing</h4>
<br>

### Dependencies

Many of the development dependencies can be installed through [homebrew](http://brew.sh)

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
  go get github.com/ip2location/ip2location-go
```

The base of the app utilizes [react-on-rails](https://github.com/shakacode/react_on_rails). For local development, use the following commands to install development dependencies, boot the rails server, and build the webpack-bundled js file:

```unix
  npm run postinstall
  npm run rails-server
```

Compiled js components will be located within `app/assets/web-bundle.js`

Because React is a dependency, it is recommended to install the [react developer tools for chrome](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi/related). Engagement scores are downsampled using a goworker. For more information on goworkers as well as influxdb (the persistence db), please consult the following links:

- goworkers: http://mildlyinternet.com/code/supercharge-resque-and-sidekiq-with-go-part-2.html
- influxdb: https://www.influxdata.com/time-series-platform/influxdb/

### Setup

```ruby
  rake db:create
  rake db:migrate:with_data
  rake db:seed
```

Please note - it may be essential to restart influxdb after seeding, as well as manually creating the [continuous queries](https://docs.influxdata.com/influxdb/v0.9/query_language/continuous_queries) from the command line

### Debugging

For debugging goworkers, please see [delve](https://github.com/go-delve/homebrew-delve)

```unix
  brew install go-delve/delve/delve
```

For remote debugging API endpoints:

```unix
  powder restart
  add `byebug` to line in code
  bundle exec byebug -R localhost:1048
  hit api endpoint with `byebug` line
```

### Deploying

Docker and Docker Compose scripts are available:

```unix
  brew install docker-compose
  brew install docker-machine
  brew install Caskroom/cask/virtualbox
```

Alternatively you can use Flynn for deployments:

```unix
  brew install flynn
  flynn install
  flynn -a dashboard env | grep LOGIN_TOKEN # for accessing login token
```
