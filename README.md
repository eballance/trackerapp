# TrackerApp [![Build Status](https://travis-ci.org/eballance/trackerapp.svg?branch=master)](https://travis-ci.org/eballance/trackerapp)

## Install

```
cp config/database.yml.examle config/database.yml
cp config/secrets.yml.example config/secrets.yml.example
bundle install
bin/rake db:setup
```

## Starting

```
bin/rails s
```

## Console

```
bin/rails c
```

## Testing
```
bin/rspec spec
```

## Contributing

1. Fork it ( https://github.com/eballance/trackerapp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
