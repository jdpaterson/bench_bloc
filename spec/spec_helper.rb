require "bundler/setup"
require "bench_bloc"
ENV["RAILS_ENV"] = "test"
require File.expand_path("./spec/dummy/config/environment.rb")

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include BenchBloc, type: :bench_bloc
end
