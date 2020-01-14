require 'bench_bloc'
require 'pry'
require 'rake'
require 'spec_helper'

RSpec.describe BenchBloc, type: :bench_bloc do
  before(:all) do
    BLOC_FILES=FileList["./spec/*.rake"]
      BLOC_FILES.each do |f|
        load f
      end
  end
  it "has a version number" do
    expect(BenchBloc::VERSION).not_to be nil
  end

  let(:task_names) {
    [
      'bench_bloc:all',
      'bench_bloc:clear_tests_util',
      'bench_bloc:parse_options_util',
      'bench_bloc:spec_namespace:spec_task'
    ]
  }

  describe "loads a rakefile which calls the task generator methods" do
    it "has the correct task names" do
      gen_tasks = Rake.application.tasks.map(&:name).flatten
      expect(gen_tasks).to match_array(task_names)
    end
    it "tasks return correct value" do
      Rake::Task.define_task(:environment)
      Rake::Task['bench_bloc:spec_namespace:spec_task'].invoke
      has_results = File.open("benchmarks.log", "r").grep(/Total Time: 3.0 seconds/)
    end
  end
end