# BenchBloc

BenchBloc is a benchmarking tool for Ruby that allows you to benchmark your code by using a simple hash syntax, which will generate rake tasks, which when run will format and log to a bench_bloc.log file. It currently allows you to bench via Ruby's built-in Benchmark API or through the ruby_prof gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bench_bloc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bench_bloc

## Usage

In a '/bench_bloc' folder at the root of your app, create any number of files that end in '\*.bloc.rb'.
In these files use the Ruby hash syntax to namespace how you want the rake tasks to be generated. Task namespaces can be nested.

To generate a task, a hash must contain at least the `prof` property, among others. The `prof` property must be a lamda, the block of which will be the code that you will benchmark.

```
{
    posts: {
        save_a_post: (obj) -> { sleep 3 }
    }
}
```

Will generate the `rake bench_bloc:posts:save_a_post` rake task.
When this task is run the results will be formatted and saved to /log/bench_bloc.log

```

---
	Test Description
	Total Time: 3.0 seconds

		Test Sleep 3 Seconds
			3.0 seconds
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jdpaterson/bench_bloc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BenchBloc project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jdpaterson/bench_bloc/blob/master/CODE_OF_CONDUCT.md).
