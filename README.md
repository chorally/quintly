# Quintly

This is a sample gem to wrap Quintly API https://api.quintly.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quintly'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quintly

## Usage

```ruby
require 'quintly'

configuration = Quintly::Configuration.new do |conf|
  conf.start_time = '2013-08-01',
  conf.end_time = '2013-08-15',
  conf.interval = 'daily', #(daily, weekly, monthly, yearly, total)
  conf.profile_ids = '1111',
  conf.username = 'your username',
  conf.password = 'your password'
end

client = Quintly::QQL.new(configuration)

# get fanCount info with predefined metric
result = client.metric('fanCount').first
#=> {"dim1"=>1111, "dim2"=>"2013-08-01 00:00:00", "fans"=>1340103}

# get fanCount info with QQL
result = client.query('SELECT profileId, time, fans FROM facebook').first
#=> {"profileId"=>1111, "time"=>"2013-08-01 00:00:00", "fans"=>1340103}


```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chorally/quintly.


## License
The quintly GEM is released under the MIT License.
