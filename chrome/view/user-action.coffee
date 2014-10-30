#import
#controller history_controller

$ ->
  controller = new HistoryController()
  now = new Date()
#  controller.changeDate("2014-01-08")
  controller.firstDate()

  $('#date').on 'change', ->
    change()

  $('#cluster_num').on 'change', ->
    change()

  change = () ->
    date = $('#date').val()
    if date == ""
      date = now
    cluster_num = $('#cluster_num').val()
    if Date.parse(now) >= Date.parse(date)
      controller.changeDate(date, cluster_num)
    else
      console.log "We can't analyze your future."
