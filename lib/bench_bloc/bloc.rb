module BenchBloc
  # Responsible for generating rake tasks from a hash and/or creating child Blocs
  class Bloc
    attr_accessor :bloc_hash, :bloc_namespaces
    def initialize bloc_hash
      @bloc_hash, @bloc_namespaces = bloc_hash, []
      # generate_bloc
    end

    def generate_bloc
      bloc_namespaces.push(
        Bloc::Namespace.new(
          :bench_bloc,
          bloc_hash
        )
      )
    end

    def [](namespace_key)
      bloc_namespaces[0].bloc_namespaces.find { |bn| namespace_key == bn.namespace_key }
    end

    private
    def is_task? obj
      obj.keys.any?(:to_profile)
    end    

    # def put_bloc_namespaces bloc
    #   bloc.keys.each do |key|
    #     namespace :bench_bloc do
    #       put_namespace key, bloc[key]
    #       put_options_parser_task
    #       put_clear_tests_task
    #       put_all_task
    #     end
    #   end
    # end

    # def put_namespace
    #   bloc_hash.keys.each do |bh_key|
    #     # binding.pry
    #     if is_task? bloc_hash[bh_key]
    #       bloc_tasks.push(
    #         BenchBloc::Bloc::Task.new(
    #           bh_key,
    #           bloc_hash
    #         )
    #       )
    #     else
    #       bloc_namespaces.push(
    #         Bloc::Namespace.new(
    #           bh_key,
    #           bloc_hash
    #         )
    #       )
    #     end
    #   end
    # end
    
    def put_task key, new_task
      desc new_task[:desc]
      task key => :environment do
        to_profs = [new_task[:to_prof].call].flatten
        bm_results = bm_run_results new_task, to_profs
        bm_log_results bm_results, new_task[:desc]
        # run ruby-prof
        # format_ruby_prof(run_ruby_prof(new_task[:prof], tp)) if @options[:ruby_prof] == true
      end
    end
    
  end
end