class @HistoryController
  constructor: ()->
    @history = new History()

  firstDate: ()->
    now = new Date()
    @.changeDate(now)

  changeDate: (date)->
    @history.changeDate(date)



