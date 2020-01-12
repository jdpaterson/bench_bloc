module BenchBloc
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/bench_bloc.rake'
    end
  end
end