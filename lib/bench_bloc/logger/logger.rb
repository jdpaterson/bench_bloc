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
      formatted_results = 
        BenchBloc::Formatter::Benchmark.new(results, title).format_results
      write_to_log formatted_results
    end

    def write_to_log results
      if defined?(Rails)        
        # Rails Logger not working, naming conflict I think, 
        # or it needs to be required        
        # log = Rails::Logger.new("#{Rails.root}/log/benchmarks.log")
        # log.info(results)
        f = File.new("#{Rails.root}/log/benchmarks.log", "w")
          f.puts(results)
          f.close
      else
        f = File.new("benchmarks.log", "w")
        f.puts(results)
        f.close
      end
    end
  end
end