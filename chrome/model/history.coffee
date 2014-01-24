# import
#
#

class @History
  changeDate: (date, searchWord = "")->
    start = Date.parse(date) - 86400000;
    end = Date.parse(date);
    jsonData = ""

    chrome.history.search("text":searchWord, "startTime":start, "endTime":end, "maxResults":100,
      (array)=>
        clustering = @clusteringHistories(array)
    )

  clusteringHistories: (array)->
    clustering = new Clustering(array)
    clustering.clustering()
    return clustering

#  selectArticle: ()->
#
#    return i


