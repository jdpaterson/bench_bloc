# TODO: turn into a module
def bm_log_results results, title
  log = Logger.new("#{__dir__}/log/benchmarks.log")
  results.sort! { |a,b| b.real <=> a.real }
  formatted_results = results.map { |res| bm_format_result(res) }
  header = "\n---\n\t#{title}\n"
  summary = "\tTotal Time: #{bm_summarize_real_time(results).round(2)} seconds\n\n"
  log.info(header + summary + formatted_results.join("\n"))
end

def bm_summarize_real_time results
  results.inject(0) do |agg, res|
    agg + res.real
  end
end

def bm_format_result result
  "\t\t#{result.label}\n\t\t\t#{result.real.round(2)} seconds"
end

def bm_run_results new_task, to_profs
  Benchmark.bm do |x|
    to_profs.each do |tp|
      x.report(new_task[:label].call(tp)) do
        new_task[:prof].call(tp)
      end
    end
  end
end