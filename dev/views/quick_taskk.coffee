$(document).ready ->
  taskk = new TaskkAPI("69511f865944f219003f22221fc742a2")
  $("#estimate").hide()
  textboxHint "main"

  $(document).keypress (e) ->
    if e.which == 13
      if $("#title").is(":visible")
        alert "hey"
        #validate the title
        $("#title").hide()
        $("#estimate").show()

      if $("#estimate").is(":visible")
        alert "het"
        #validate the estimate
        taskk.create_task "something", "5m", 21340
        $("#estimate").hide()
        $("#title").show()
    return true
  return

