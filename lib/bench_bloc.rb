require 'bench_bloc/version'
require 'bench_bloc/helpers/benchmark_helpers'
require 'bench_bloc/helpers/rake_helpers'
require 'bench_bloc/helpers/ruby_prof_helpers'
require 'bench_bloc/railtie' if defined?(Rails)

module BenchBloc
  class Error < StandardError; end
  include BenchBloc::BenchmarkHelpers
  include BenchBloc::RakeHelpers
  include BenchBloc::RubyProfHelpers
end
