
class @History
  changeDate: (date, searchWord = "")->
    start = Date.parse(date) - 86400000;
    end = Date.parse(date);
    jsonData = ""

    histories = []
    chrome.history.search("text":searchWord, "startTime":start, "endTime":end,"maxResults":1000,
      (array)=>
        console.log array.length

        contents = null

        for a in array
          chrome.storage.local.get a['url'], (items)->
            console.log items
#            a['content'] = contents[a['url']]

        $.ajax (
          type: 'post',
          url: 'http://127.0.0.1:8000/historypaper/receive/historyobj/',
          data: {"length":String(array.length), "data": array},
#          dataType: 'json',
          success: (data) ->
            console.log data
          ,
          error: (xhr, type) ->
            console.log 'AjaxError:', xhr, type
        )
#        console.log JSON.stringify(array)
#        histories = @clusteringHistories(array)
#        layout = new Layout(histories)
#        layout.drawArticles()
    )

