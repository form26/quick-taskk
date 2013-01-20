$(document).ready ->
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
    @show_login = ko.observable(true)
    @show_create_task = ko.observable(false)
    @show_change_list = ko.observable(false) 
    return

  ViewModel = new QuickTaskk
  taskk_api = new TaskkAPI

  ko.applyBindings ViewModel

  if localStorage.api_key
    ViewModel.api_key = localStorage.api_key
  else
    #display login


    # ViewModel.api_key = data.token
  

  #check local storage for settings / load settings

  #Login

  $("#sign_in").submit ->
    username = $("#username").val()
    password = $("#password").val()
    login = taskk_api.login(username,password)
    login.success (data) ->
      localStorage['api_key'] = data.token
      ViewModel.api_key = localStorage.api_key 
    return

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
        $("#estimate").focus()
    return true
  return

