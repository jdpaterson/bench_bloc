# TODO: Implement OptionsParser ie --rubyprof
require 'rake'
require 'pry'
require 'benchmark'
require 'bench_bloc'
require 'bench_bloc/rake_helper.rb'

# TODO: Look recursively in folders using 'bench_bloc/**/*.bloc.rb
CONFIG_FILES=FileList["bench_bloc/*.bloc.rb"]

def put_namespace key, namespace
  namespace key do
    namespace.keys.each do |ns_key|
      if is_task? namespace[ns_key]
        put_task ns_key, namespace[ns_key]
      else
        put_namespace ns_key, namespace[ns_key]
      end
    end
  end
end

# TODO: Add a ruby-prof method here if argument is passed
def put_task key, new_task
  desc new_task[:desc]
  task key => :environment do
    to_profs = [new_task[:to_prof].call].flatten
    results = Benchmark.bm do |x|
      to_profs.each do |tp|
        x.report(new_task[:label].call(tp)) do
          new_task[:prof].call(tp)
        end
      end
    end
    log_results results, "Benchmark Complex Validation Rules on Small Timesheet"
  end
  # format_ruby_prof(run_ruby_prof(new_task[:prof], tp)) if @options[:ruby_prof] == true
end

# def run_ruby_prof lam, args
#   RubyProf.start
#     lam.call args
#   RubyProf.end
# end

# def format_ruby_prof res
#   "Formatted Ruby Prof Results: #{res}"
# end

def is_task? obj
  obj.keys.any?(:to_prof)
end

CONFIG_FILES.each do |f|
  config = eval File.read(f)
  config.keys.each do |key|
    namespace :bench_bloc do
      put_namespace key, config[key]
      desc "Options parser for bench tasks"
      task parse_options_util: :environment do
        @options = {}
        option_parser.parse!
        option_parser.parse!
      end
      desc "Clear Tests"
      task clear_tests_util: :environment do
        at_exit do
          test_ts = Timesheet.where("general_remarks LIKE '%BENCHTEST%'")
          puts "Clearing #{test_ts.count} test timesheets"
          test_ts.destroy_all
        end
      end
      desc "Run all benchmarks"
      task all: :environment do
        bench_tasks.each(&:execute)
        Rake::Task["bench_bloc:clear_tests_util"].invoke
      end
    end
  end
end

bench_tasks.each do |task|
  Rake::Task[task.name]
    .enhance(['bench_bloc:parse_options_util', 'bench_bloc:clear_tests_util'])
end
