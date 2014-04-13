#import
#controller history_controller

$ ->
  controller = new HistoryController()
  now = new Date()
#  controller.changeDate("2014-01-08")
  controller.firstDate()

  $('#date').on 'change', ->
    date = $('#date').val()
    console.log "change date", date
    if Date.parse(now) > Date.parse(date)
      controller.changeDate(date)
    else
      console.log "We can't analyze your future."

#  lay = new Layout()
#  lay.createLayout()
