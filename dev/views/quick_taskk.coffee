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
    @show_login = ko.observable(false)

    @show_create_task = ko.observable(false)

    @lists = ko.mapping.fromJS([])

    @selected_list = ko.observable('')

    # if API key is valid. Allow to add tasks
    @check_key = () =>
      # check if saved API key is valid
      ping = taskk_api.ping()
      ping.success (data) =>
        @show_login(false)
        @show_create_task(true)
        @load_lists()
        return
      ping.error (data) =>
        $("#login_loader").hide()
        @show_login(true)
        return
      return

    @load_lists = () =>
      get_lists = taskk_api.get_lists()
      get_lists.success (data) =>
        ko.mapping.fromJS(data,@lists)
        return
      get_lists.error (data) =>
        alert("uh oh! couldn't load your lists!")
        return
      return

    @logged_in = (key) =>
      localStorage.api_key = key
      @api_key = key
      taskk_api.set_token(key)
      @check_key()
      return

    return

  ViewModel = new QuickTaskk
  taskk_api = new TaskkAPI

  ko.applyBindings ViewModel

  if localStorage.api_key
    ViewModel.logged_in(localStorage.api_key)
  else
    $("#login_loader").hide()
    ViewModel.show_login(true)
  

  $("#sign_in").submit ->
    username = $("#username").val()
    password = $("#password").val()

    $("#username").attr("disabled", "disabled")
    $("#password").attr("disabled", "disabled")

    $("#submit").hide();
    $("#login_loader").show();

    login = taskk_api.login(username,password)
    login.success (data) ->
      ViewModel.logged_in(data.token)
    login.error (data) ->
      alert "login failed dude" 
    return false

  $("#estimate").hide()
  $("#message").hide()
  $("#loader").hide()  

  $(document).keypress (e) ->
    if e.which == 13
      if $("#estimate").is(":visible")
        #validate the estimate
        title = $("#task_title").val()
        estimate = $("#estimate").val()
        sel_list = $("#select_list").val()
        $("#estimate").hide()
        $("#loader").show()
        new_task = taskk_api.create_task title, estimate, sel_list

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

