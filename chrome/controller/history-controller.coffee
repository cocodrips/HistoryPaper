class @HistoryController
  constructor: ()->
    @history = new History()

  firstDate: () ->
    now = new Date()
    @changeDate(now)

  changeDate: (date) ->
    @clearView()
    @history.changeDate(date)

  clearView: () ->
    console.log "clear"
    $("#main-container").innerHTML = ''


