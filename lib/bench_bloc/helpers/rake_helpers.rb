require 'optparse'
require 'rake'
module BenchBloc::RakeHelpers
  def bench_tasks
    Rake.application.tasks.select do |task|
      task.name.starts_with?("bench_bloc") &&
      !task.name.ends_with?("_util") &&
      task.name != "bench_bloc:all"
    end
  end

  def option_parser
    OptionParser.new do |opts|
      opts.banner = "Usage: rake bench_bloc:* [options]"
      opts.on("-r", "--ruby-prof", "Print a RubyProf report") do |rp|
        @options[:ruby_prof] = rp
      end
    end
  end

  def put_options_parser_task
    desc "Options parser for bench tasks"
    task parse_options_util: :environment do
      @options = {}
      option_parser.parse!
      option_parser.parse!
    end
  end

  def put_clear_tests_task
    desc "Clear Tests"
    task clear_tests_util: :environment do
      at_exit do
        test_ts = Timesheet.where("general_remarks LIKE '%BENCHTEST%'")
        puts "Clearing #{test_ts.count} test timesheets"
        test_ts.destroy_all
      end
    end
  end

  def put_all_task
    desc "Run all benchmarks"
    task all: :environment do
      bench_tasks.each(&:execute)
      Rake::Task["bench_bloc:clear_tests_util"].invoke
    end
  end

  def add_bench_hooks
    bench_tasks.each do |task|
    Rake::Task[task.name]
      .enhance(['bench_bloc:parse_options_util', 'bench_bloc:clear_tests_util'])
    end
  end
end