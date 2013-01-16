$(document).ready ->
  taskk = new TaskkAPI("977a1ac598e8c6da8b42b5f2b1b8af67")
  $("#estimate").hide()
  textboxHint "main"

  $(document).keypress (e) ->
    if e.which == 13
      if $("#estimate").is(":visible")
        #validate the estimate
        title = $("#title").val()
        estimate = $("#estimate").val()
        taskk.create_task title, estimate, 6208
        $("#estimate").hide()
        $("#title").show()

      if $("#title").is(":visible")
        #validate the title
        $("#title").hide()
        $("#estimate").show()
    return true
  return

