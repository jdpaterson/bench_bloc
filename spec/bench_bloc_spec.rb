require 'pry'
require 'spec_helper'
require 'bench_bloc'

RSpec.describe BenchBloc, type: :bench_bloc do
  before(:all) do
    BLOC_FILES = FileList["./spec/*.rake"]
    BLOC_FILES.each do |f|
      load f
    end
  end
  it "has a version number" do
    expect(BenchBloc::VERSION).not_to be nil
  end
  describe "Basic bloc generator" do
    it "generates a bloc with correct task name" do
      bbh = eval File.read("./spec/fixtures/namespace_fixture.rb")
      bb = BenchBloc::Bloc.new(bbh)
      bb.generate_bloc
      has_spec_test = bb[:spec_namespace]
                      .bloc_tasks
                      .any? { |bt| bt.namespace == :spec_task }
      expect(has_spec_test).to eq(true)
    end
  end

  let(:task_names) {
    [
      'bench_bloc:spec_namespace:spec_task'
    ]
  }
  describe "Correct rake tasks are generated" do
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

  describe "Boot up dummy rails app" do
    it "tasks are loaded on load_tasks" do       
      Rails.application.load_tasks
      has_bench_bloc_task = Rake
                            .application
                            .tasks
                            .any? { |rt| 
                              rt.name.starts_with?('bench_bloc')
                            }
      expect(has_bench_bloc_task).to eq(true)
    end
  end
end