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