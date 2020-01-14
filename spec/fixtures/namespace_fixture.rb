{
  spec_namespace: {
    spec_task: {
      desc: "Test Description",
      label: -> (obj) {"Test Sleep 3 Seconds"},
      prof: -> (obj) {
        sleep(3)
      },
      to_prof: -> () { "Test Prof" }
    }
  }
}