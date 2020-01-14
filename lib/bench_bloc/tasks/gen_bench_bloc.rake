# TODO: Implement OptionsParser ie --rubyprof
require 'rake'
require 'pry'
require 'benchmark'
require 'bench_bloc/helpers/benchmark_helpers'
require 'bench_bloc/helpers/rake_helpers.rb'

# TODO: Look recursively in folders using 'bench_bloc/**/*.bloc.rb
BLOC_FILES=FileList["bench_bloc/*.bloc.rb"]

BLOC_FILES.each do |f|
  bloc = eval File.read(f)
  put_bloc_namespaces bloc
end

add_bench_hooks

