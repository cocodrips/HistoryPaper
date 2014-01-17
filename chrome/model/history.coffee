# import
#
#

class @History
  changeDate: (date, searchWord = "")->
    start = Date.parse(date) - 86400000;
    end = Date.parse(date);
    jsonData = ""

    chrome.history.search("text":searchWord, "startTime":start, "endTime":end, "maxResults":10,
      (array)=>
        clustering = new Clustering(array)
        clustering.addKeys2Histories()
    )
