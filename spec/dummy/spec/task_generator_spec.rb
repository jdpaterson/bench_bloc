require 'spec_helper'

RSpec.describe "Rails App" do
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