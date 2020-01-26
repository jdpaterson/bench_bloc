{
  spec_namespace: {
    spec_task: {
      description: "Test Description",
      label: -> (obj) {"Test Sleep 1 Seconds"},
      profile: -> (obj) {
        sleep(1)
      },
      to_profile: -> () { "Test Prof" },
    },
    ruby_prof_task: {
      description: "Ruby Prof Task",
      label: -> (obj) {"Test Sleep 1 Seconds"},
      profile: -> (obj) {
        sleep(1)
      },
      ruby_prof: true,
      to_profile: -> () { "Test Ruby Prof Task" },
    }
  }
}