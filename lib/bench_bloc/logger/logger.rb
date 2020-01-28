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
        f = File.open("#{Rails.root}/log/benchmarks.log", "a")
          f.puts(results)
          f.puts(parse_db_logger)
          f.close
      else
        f = File.new("benchmarks.log", "a")
        f.puts(results)
        f.puts(parse_db_logger)
        f.close
      end
    end

    private

    def parse_db_logger
      if defined?(Rails)
        log_data = File.read($rails_db_logger_path).split("\n")
        base_aggregator = {
          SELECT: 0,
          INSERT: 0,
          UPDATE: 0,
          DELETE: 0
        }
        query_data = log_data.reduce(base_aggregator) do |agg, ld|
          sql_verb = ld[/SELECT|INSERT|UPDATE|DELETE/]
          agg[sql_verb.to_sym] += 1 if sql_verb.present?
          agg
        end
      end
    end
  end
end