module BenchBloc
  class Bloc::Namespace < BenchBloc::Bloc
    attr_reader :bloc_namespaces, :bloc_tasks, :namespace_key
    def initialize namespace_key, bloc_hash
      super(bloc_hash)
      @namespace_key = namespace_key
      @bloc_namespaces, @bloc_tasks = [], []      
      put_namespace
    end

    def put_namespace
      bloc_hash.keys.each do |bh_key|        
        if is_task? bloc_hash[bh_key]
          bloc_tasks.push(
            BenchBloc::Bloc::Task.new(
              bh_key,
              bloc_hash[bh_key]
            )
          )
        else
          bloc_namespaces.push(
            Bloc::Namespace.new(
              bh_key,
              bloc_hash[bh_key]
            )
          )
        end
      end
    end    

    # private
    
    # def put_namespace
    #   namespace key do
    #     namespace.keys.each do |ns_key|
    #       if is_task? namespace[ns_key]
    #         put_task ns_key, namespace[ns_key]
    #       else
    #         put_namespace ns_key, namespace[ns_key]
    #       end
    #     end
    #   end
    # end
  end
end