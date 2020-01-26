require 'rake'
module BenchBloc::Raker
  include Rake::DSL
  def bench_tasks
    Rake.application.tasks.select do |task|
      task.name.starts_with?("bench_bloc") &&
      !task.name.ends_with?("_util") &&
      task.name != "bench_bloc:all"
    end
  end

  def put_all_task
    desc "Run all benchmarks"
    task all: :environment do
      bench_tasks.each(&:execute)
      Rake::Task["bench_bloc:clear_tests_util"].invoke
    end
  end

end