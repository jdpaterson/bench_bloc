require 'rake'
require 'pry'
require 'benchmark'
require 'bench_bloc/helpers/benchmark_helpers'
require 'bench_bloc/helpers/rake_helpers.rb'

include BenchBloc
BLOC_FILES=FileList["./spec/fixtures/namespace_fixture.rb"]

BLOC_FILES.each do |f|
  bloc = eval File.read(f)
  put_bloc_namespaces bloc
end

# add_bench_hooks

