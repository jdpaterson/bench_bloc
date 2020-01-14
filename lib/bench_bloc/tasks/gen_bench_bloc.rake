require 'rake'
require 'bench_bloc'

# TODO: Look recursively in folders using 'bench_bloc/**/*.bloc.rb
BLOC_FILES=FileList["bench_bloc/*.bloc.rb"]

include BenchBloc

BLOC_FILES.each do |f|
  bloc = eval File.read(f)
  put_bloc_namespaces bloc
end

add_bench_hooks

