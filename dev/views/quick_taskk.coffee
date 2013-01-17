$(document).ready ->
  taskk = new TaskkAPI("977a1ac598e8c6da8b42b5f2b1b8af67")
  $("#estimate").hide()
  $("#message").hide()
  $("#loader").hide()
  textboxHint "main"

  $(document).keypress (e) ->
    if e.which == 13
      if $("#estimate").is(":visible")
        #validate the estimate
        title = $("#task_title").val()
        estimate = $("#estimate").val()
        $("#estimate").hide()
        $("#loader").show()
        new_task = taskk.create_task title, estimate, 6208

        new_task.success (data) -> 
          $("#loader").hide()
          $("#task_title").val('')
          $("#estimate").val('')
          $("#task_title").show() 
          $('#task_title').blur()
          $("#message").text("Task created!")
          $("#message").fadeIn('fast').delay('2000').fadeOut('fast')
          return false
        
      else if $("#task_title").is(":visible")
        #validate the title
        $("#task_title").hide()
        $("#estimate").show()
        setTimeout (->
          $("#estimate").focus()
        ), 750
    return true
  return

