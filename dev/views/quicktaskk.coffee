#define view model
window.QuickTaskk = ->
  @task_estimate = ko.observable().extend(
    required: true
  )
  @task_title = ko.observable().extend(
    required: true
  )
  @username = ko.observable('')
  @password = ko.observable('')

  @show_login = ko.observable(false)

  @show_loader = ko.observable(false)

  @show_estimate = ko.observable(false)

  @show_title = ko.observable(true)

  @show_create_task = ko.observable(false)

  @lists = ko.mapping.fromJS([])

  @selected_list = ko.observable()

  @set_token = (key) =>
    taskk_api.set_token(key)

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
      @log_out()
      return
    return

  @log_out = () =>
    $("#login_loader").hide()
    @show_create_task(false)
    @show_login(true)
    $("#username").focus()
    $("#username").removeAttr('disabled');
    $("#password").removeAttr('disabled');
    localStorage.removeItem("api_key")
    localStorage.removeItem("selected_list")
    return

  @load_lists = () =>
    get_lists = taskk_api.get_lists()
    get_lists.success (data) =>
      ko.mapping.fromJS(data,@lists)
      $("#select_list").trigger("liszt:updated")
      return
    get_lists.error (data) =>
      alert("uh oh! couldn't load your lists!")
      return
    return


  @log_in = () =>
    username = $("#username").val()
    password = $("#password").val()

    $("#username").attr("disabled", "disabled")
    $("#password").attr("disabled", "disabled")

    $("#submit").hide();
    $("#login_loader").show();

    # login/get API key via API
    login = taskk_api.login(username,password)
    login.success (data) =>
      localStorage.api_key = data.token
      taskk_api.set_token(data.token)
      @show_login(false)
      @show_create_task(true)
      @load_lists()
      return
    login.error (data) =>
      $("#submit").show();
      $("#login_loader").hide();
      $("#username").removeAttr('disabled');
      $("#password").removeAttr('disabled');
      $("#message_login").fadeIn('fast').delay('2000').fadeOut('fast')
      return
    return

  return