module BenchBloc
  class Formatter
    attr_reader :results, :title
    def initialize results, title
      @results, @title = results, title
    end
  end
end