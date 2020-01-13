require 'bench_bloc/version'
require 'optparse'
require 'bench_bloc/railtie' if defined?(Rails)

module BenchBloc
  class Error < StandardError; end

end
