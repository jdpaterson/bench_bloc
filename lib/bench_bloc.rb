require 'bench_bloc/bloc/bloc'
require 'bench_bloc/bloc/bloc_namespace'
require 'bench_bloc/bloc/bloc_task'
require 'bench_bloc/formatter/formatter'
require 'bench_bloc/formatter/benchmark'
require 'bench_bloc/logger/logger'
require 'bench_bloc/railtie' if defined?(Rails)
require 'bench_bloc/version'


module BenchBloc
  class Error < StandardError; end
end
