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
  bloc.keys.each do |key|
    namespace :bench_bloc do
      put_namespace key, config[key]
      put_options_parser_task
      put_clear_tests_task
      put_run_all_task
    end
  end
end

add_bench_hooks

