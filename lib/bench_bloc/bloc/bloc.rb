require 'rake'
module BenchBloc
  # Responsible for generating rake tasks from a hash and/or creating child Blocs
  class Bloc
    include Rake::DSL
    attr_accessor :bloc_hash, :bloc_namespaces
    def initialize bloc_hash
      @bloc_hash, @bloc_namespaces = bloc_hash, []
    end

    def generate_bloc
      bloc_namespaces.push(
        Bloc::Namespace.new(
          :bench_bloc,
          bloc_hash,
          true
        )
      )
    end

    def rake_bloc
      bloc_namespaces.each do |bn|
        bn.rake_namespace
      end
    end

    def [](namespace_key)
      bench_bloc_namespace
        .bloc_namespaces
        .find { |bn| namespace_key == bn.namespace_key }
    end

    private
    def is_task? obj
      obj.keys.any?(:profile)
    end

    def bench_bloc_namespace
      bloc_namespaces[0]
    end
  end
end