require 'ruby-prof'
module BenchBloc
  class Logger::RubyProf < BenchBloc::Logger
    def log_results
      formatted_results = BenchBloc::Formatter::RubyProf
                          .new(results, title)
                          .format_results
      write_to_log formatted_results
    end

    def write_to_log results
      if defined?(Rails)
        printer = ::RubyProf::FlatPrinter.new(results)
        File.open("#{Rails.root}/log/bench_bloc_ruby-prof.log", 'w') { |file|
          printer.print(file)
        }
      else
        printer = ::RubyProf::FlatPrinter.new(results)
        File.open("log/bench_bloc_ruby-prof.log", "w") { |file|
          printer.print(file)
        }
      end
    end
  end
end