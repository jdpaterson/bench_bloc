{
  spec_namespace: {
    spec_task: {
      description: "Test Description",
      label: -> (obj) {"Test Sleep 3 Seconds"},
      profile: -> (obj) {
        sleep(3)
      },
      to_profile: -> () { "Test Prof" }
    }
  }
}