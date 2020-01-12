module BenchBloc
  class Railtie < Rails::Railtie
    railtie_name :bench_bloc
    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/gen_bench_bloc.rake").each { |f| load f }
    end
  end
end