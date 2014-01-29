#import
#controller history_controller

$ ->
  controller = new HistoryController()
  console.log controller
  now = new Date()
  controller.firstDate()
  controller.changeDate(now)

  $('#date').on 'change', ->
    date = $('#date').val()
    console.log date
    if Date.parse(now) > Date.parse(date)
      controller.changeDate(date)
    else
      console.log "We can't analyze your future."

#  lay = new Layout()
#  lay.createLayout()
