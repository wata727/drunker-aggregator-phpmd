# Drunker::Aggregator::Phpmd

[PHPMD](https://github.com/phpmd/phpmd) aggregator for [Drunker](https://github.com/wata727/drunker)

## Installation

    $ gem install drunker-aggregator-phpmd

## Usage

```
$ drunker run --aggregator=phpmd phpmd_image:latest phpmd ./ xml cleancode
```

Currently, this aggregator only supports for XML report format.

## Exit Status

Returns the maximum value of the exit status of each build. If the build failed, it will be treated as returning exit status 1.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wata727/drunker-aggregator-phpmd. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

