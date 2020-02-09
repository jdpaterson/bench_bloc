# require 'bench_bloc'
module BenchBloc
  class Bloc::Task < BenchBloc::Bloc
    attr_reader :description,
                :label,
                :namespace,
                :profile,
                :title,
                :to_profile
                :ruby_prof

    def initialize namespace, bloc_task
      super(bloc_task)
      @namespace = namespace
      parse_bloc_task bloc_task
    end

    def rake_task
      desc description
      task namespace => :environment do
        BenchBloc::Logger.new(run_benchmark, description).log_results
        BenchBloc::Logger::RubyProf
          .new(run_ruby_prof, description)
          .log_results if @ruby_prof == true
      end
    end

    private

    def run_benchmark
      Benchmark.bm do |x|
        [to_profile.call].flatten.each do |otp|
          new_label = label.call(otp)
          set_db_logger
          x.report(new_label) do
            profile.call(otp)
          end
        end
      end
    end

    def run_ruby_prof
      rp_profile = RubyProf::Profile.new
      result = rp_profile.profile do
        @profile.call
      end
    end

    def parse_bloc_task bloc_task
      @description = bloc_task[:description]
      @label = bloc_task[:label]
      @profile = bloc_task[:profile]
      @title = bloc_task[:title]
      @to_profile = bloc_task[:to_profile]
      @ruby_prof = bloc_task[:ruby_prof] || false
    end

    def set_db_logger
      $rails_db_logger_path = "#{Rails.root}/log/bench_bloc_#{Time.now}_db_queries.log"
      if defined?(Rails)
        ActiveRecord::Base.logger = ::Logger.new($rails_db_logger_path)
      end
    end
  end

end