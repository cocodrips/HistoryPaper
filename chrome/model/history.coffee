data = []

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
            b = 1
#            console.log items
#            a['content'] = contents[a['url']]

#        $.ajax (
#          type: 'post',
#          url: 'http://127.0.0.1:8000/historypaper/receive/historyobj/',
#          data: {"length":String(array.length), "data": array},
##          dataType: 'json',
#          success: (data) ->
#            console.log data
#          ,
#          error: (xhr, type) ->
#            console.log 'AjaxError:', xhr, type
#        )

#        console.log JSON.stringify(array)
#        histories = @clusteringHistories(array)
#        layout = new Layout(histories)
#        layout.drawArticles()
        layout = new Layout(data)
        layout.drawArticles()
    )





test_data = [
  ["8.3. collctions — High-performance container datatypes", "https://docs.python.org/2/library/collections.html"],
  ["", "", ""],
  ["", "", ""],
  ["", "", ""],
  ["", "", ""],
  ["AngularJS — Superheroic JavaScript MVW Framework", "https://angularjs.org/"]
  ["Floyd–Warshall algorithm", "http://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm", """  "Floyd's algorithm" redirects here. For cycle detection, see Floyd's cycle-finding algorithm. For computer graphics, see Floyd–Steinberg dithering.
                                                                                                                                          Floyd–Warshall algorithm
                                                                                                                                          Class	All-pairs shortest path problem (for weighted graphs)
                                                                                                                                          Data structure	Graph

                                                                                                                                          """],
  ["", "", ""],
  ["", "", ""],
  ["", "", ""]
]

test_rect=[
  [0, 0, 510, 464] ,
  [510, 0, 445, 421.052631579] ,
  [510, 421.052631579, 445, 368.421052632] ,
  [955, 0, 445, 421.052631579] ,
  [955, 421.052631579, 445, 368.421052632] ,
  [0, 464, 510, 178] ,
  [510, 789.473684211, 445, 210.526315789] ,
  [955, 789.473684211, 445, 210.526315789] ,
  [0, 642, 510, 178] ,
  [0, 820, 510, 178] ,
]


for i in [0...10]
  data[i] = new HistoryObject()
  data[i].rect = new Rect(test_rect[i][0],test_rect[i][1],test_rect[i][2],test_rect[i][3])
  data[i].title = test_data[i][0]
  data[i].url = test_data[i][1]
  data[i].content = test_data[i][2]