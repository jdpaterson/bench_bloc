require 'rake'
require 'bench_bloc'

# TODO: Look recursively in folders using 'bench_bloc/**/*.bloc.rb
BLOC_FILES=FileList["bench_bloc/*.bloc.rb"]

include BenchBloc

BLOC_FILES.each do |f|
  bench_bloc_hash = eval File.read("./spec/fixtures/namespace_fixture.rb")
  bench_bloc = BenchBloc::Bloc.new(bench_bloc_hash)
  bench_bloc.generate_bloc
  bench_bloc.rake_bloc
end

# add_bench_hooks

