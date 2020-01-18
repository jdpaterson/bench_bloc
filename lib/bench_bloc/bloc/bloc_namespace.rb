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

    def rake_namespace
      namespace namespace_key do
        bloc_tasks.each do |bt|
          bt.rake_task
        end
        bloc_namespaces.each do |bn|
          bn.rake_namespace
        end
      end
    end

  end
end