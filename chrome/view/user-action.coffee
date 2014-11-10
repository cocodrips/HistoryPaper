#import
#controller history_controller

$ ->
  controller = new HistoryController()
  controller.firstDate()

  $('#date').on 'change', ->
    change()

  $('#cluster_num').on 'change', ->
    change()

  $('input[name="tech"]').on 'change', ->
    change()

  change = () ->
    date = $('#date').val()
    if date == ""
      date = new Date()
    cluster_num = $('#cluster_num').val()
    tech_type = 0

    for t in $('input[name="tech"]')
      if t.checked
        tech_type = t.value

    now = new Date()
    if Date.parse(now) >= Date.parse(date)
      controller.changeDate(date, cluster_num, tech_type)
    else
      console.log "We can't analyze your future."
