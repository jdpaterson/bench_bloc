require 'bench_bloc'
module BenchBloc
  class Bloc::Task < BenchBloc::Bloc
    attr_reader :description, 
                :label, 
                :namespace, 
                :profile, 
                :title, 
                :to_profile
    
    def initialize namespace, bloc_task
      super(bloc_task)
      @namespace = namespace
      parse_bloc_task bloc_task
    end

    # TODO: Put into a TaskRunner class
    def run_task
      Benchmark.bm do |x|
        [to_profile.call].flatten.each do |otp|
          x.report(label.call(otp)) do
            profile.call(otp)
          end
        end
      end
    end

    def rake_task
      desc description
      task namespace => :environment do
        BenchBloc::Logger.new(run_task, description).log_results
        # run ruby-prof
        # format_ruby_prof(run_ruby_prof(new_task[:prof], tp)) if @options[:ruby_prof] == true
      end
    end

    private 
    
    def parse_bloc_task bloc_task
      @description = bloc_task[:description]
      @label = bloc_task[:label]      
      @profile = bloc_task[:profile]
      @title = bloc_task[:title]
      @to_profile = bloc_task[:to_profile]
    end
  end
end