class @HistoryController
  constructor: ()->
    @history = new History()

  firstDate: () ->
    now = new Date()
    @changeDate(now, -1)

  changeDate: (date, cluster_num) ->
    @clearView()
    @history.changeDate(date, cluster_num)

  clearView: () ->
    $("#main-container").empty()
    $('.icons').css('display', 'none')
    $('.loading').css('display', 'block')


