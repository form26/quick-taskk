# enable validation
ko.validation.init()

#define view model
QuickTaskk = ->
  @api_key = ko.observable()
  @default_list = ko.observable()
  @task_estimate = ko.observable().extend(
    required: false
    pattern: 
      message: "Incorrect format. Ex: 5m or 2h"
      params: "\d+(h\w*|m\w*)+"
  )
  @task_title = ko.observable().extend(
    required: true
  )
  @username = ko.observable().extend(
    required: true
  )
  @password = ko.observable().extend(
    required: true
  )



$(document).ready ->
  ViewModel = new QuickTaskk
  taskk_api = new TaskkAPI


    # ViewModel.api_key = data.token
  # ko.applyBindings ViewModel

  #check local storage for settings / load settings

  #Login

  $("#sign_in").submit ->
    username = $("#username").val()
    password = $("#password").val()
    login = taskk_api.login(username,password)
    login.success (data) -> 
      alert(JSON.stringify(data))
    return
  
    # taskk.

  $("#estimate").hide()
  $("#message").hide()
  $("#loader").hide()  

  $(document).keypress (e) ->
    if e.which == 13
      if $("#estimate").is(":visible")
        #validate the estimate
        title = $("#task_title").val()
        estimate = $("#estimate").val()
        $("#estimate").hide()
        $("#loader").show()
        new_task = taskk_api.create_task title, estimate, 6208

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

