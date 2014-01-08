class @Cluster
  constructor:(histories)->
    console.log "Cluster"
    @histories = histories

  print_title: () ->
    console.log @histories
