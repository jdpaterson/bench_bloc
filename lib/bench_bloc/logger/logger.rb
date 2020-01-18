require 'bench_bloc'
module BenchBloc
  class Logger
    attr_reader :results, :title
    def initialize results, title
      @results, @title = results, title
    end

    # TODO: Split into a BenchmarkLogger class
    def log_results
      results.sort! { |a, b| b.real <=> a.real }
      formatted_results = results.map { |res| bm_format_result(res) }
      header = "\n---\n\t#{title}\n"
      summary = "\tTotal Time: #{bm_summarize_real_time(results).round(2)} seconds\n\n"
      final_results = header + summary + formatted_results.join("\n")
      write_to_log final_results
    end

    def write_to_log results
      if defined?(Rails)
        log = Logger.new("#{Rails.root}/log/benchmarks.log")
        log.info(results)
      else
        f = File.new("benchmarks.log", "w")
        f.puts(results)
        f.close
      end
    end
  end
end