require 'bench_bloc'
module BenchBloc
  class Formatter::Benchmark < BenchBloc::Formatter

    def format_results
      formatted_results = results.map { |res| format_result(res) }
      header = "\n---\n\t#{title}\n"
      summary = "\tTotal Time: #{summarize_real_time(results).round(2)} seconds\n\n"
      final_results = header + summary + formatted_results.join("\n")
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
end