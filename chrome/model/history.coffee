
class @History
  changeDate: (date, searchWord = "")->
    start = Date.parse(date) - 86400000;
    end = Date.parse(date);
    jsonData = ""

    histories = []
    chrome.history.search("text":searchWord, "startTime":start, "endTime":end, "maxResults":100,
      (array)=>
        $.ajax (
          type: 'post',
          url: '',
          data: array

        )
        histories = @clusteringHistories(array)
        layout = new Layout(histories)
        layout.drawArticles()
    )



