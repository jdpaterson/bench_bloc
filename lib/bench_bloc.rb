require 'bench_bloc/version'
require 'optparse'
require 'bench_bloc/railtie' if defined?(Rails)

module BenchBloc
  class Error < StandardError; end

  def log_results results, title
    log = Logger.new("../log/benchmarks.log")
    results.sort! { |a,b| b.real <=> a.real }
    formatted_results = results.map { |res| format_result(res) }
    header = "\n---\n\t#{title}\n"
    summary = "\tTotal Time: #{summarize_real_time(results).round(2)} seconds\n\n"
    log.info(header + summary + formatted_results.join("\n"))
  end

  def log_ruby_prof_results
    # prof = RubyProf::Profile.new()
    # prof.exclude_common_methods!
    # validator = ValidationRules::TsValidatorService.new(ts)
    # complex_rules = validator.get_complex_validation_rules
    # binding.pry
    # results = prof.profile { validator.run_complex_vr(complex_rules[0]) }
    # log_prof_results results
  end

  def summarize_real_time results
    results.inject(0) do |agg, res|
      agg + res.real
    end
  end

  def format_result result
    "\t\t#{result.label}\n\t\t\t#{result.real.round(2)} seconds"
  end
end
