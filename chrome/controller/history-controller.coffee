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
    $("#main-container").empty()
    $('.loading').css('display', 'block')


