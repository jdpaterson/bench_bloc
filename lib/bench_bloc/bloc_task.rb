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

    def rake_task
      desc description
      task namespace => :environment do
        to_profs = [to_profile.call].flatten
        bm_results = bm_run_results self, to_profs
        bm_log_results bm_results, description
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