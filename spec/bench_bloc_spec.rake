require 'rake'
require 'pry'
require 'benchmark'

include BenchBloc

BLOC_FILES=FileList["./spec/fixtures/namespace_fixture.rb"]

BLOC_FILES.each do |f|
  bbh = eval File.read("./spec/fixtures/namespace_fixture.rb")
  bb = BenchBloc::Bloc.new(bbh)
  bb.generate_bloc
  bb.rake_bloc
end