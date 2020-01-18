require 'bench_bloc'
module BenchBloc
  class Formatter::Benchmark < BenchBloc::Formatter

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