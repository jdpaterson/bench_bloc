def bench_tasks
  Rake.application.tasks.select do |task|
    task.name.starts_with?("bench") &&
    !task.name.ends_with?("_util") &&
    task.name != "bench:all"
  end
end

def option_parser
  OptionParser.new do |opts|
    opts.banner = "Usage: rake bench:* [options]"
    opts.on("-r", "--ruby-prof", "Print a RubyProf report") do |rp|
      @options[:ruby_prof] = rp
    end
  end
end