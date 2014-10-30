histories = []

class @History

  changeDate: (date, cluster_num, searchWord = "")->
    start = Date.parse(date) - (86400000 * 2)
    end = Date.parse(date) - 86400000

    query = {
      "text": searchWord,
      "startTime": start,
      "endTime": end,
      "maxResults": 1000
    }

    if query.length <= 0
      layout = new Layout({})
      layout.no_data()
      return


    chrome.history.search(query, (array)=>
      keywords = searchWordList(array)
      post_data = {}
      urls = (a['url'] for a in array)
      for a in array
        if a['url'].indexOf("http://") != -1
          post_data[a['url']] = {
            'id': a['id']
            'title': a['title'],
            'content': '',
            'url': a['url'],
            'visitCount': a['visitCount'],
          }


      chrome.storage.local.get urls,
        ((post_data, keywords, date, cluster_num) ->
          (items) ->
            for key, value of items
              if key.indexOf("https") == -1
                post_data[key]['content'] = value
            console.log post_data
            post_data = (data for data in _.values(post_data))
            post_data = {
              'data': post_data,
              'date': date,
              'width': window.innerWidth - 380,
              'height': window.innerHeight - 150, 600,
              'keywords':keywords,
              'cluster_num': cluster_num
            }

            $.ajax (
              type: 'post',
              url: 'http://192.168.113.2:5000/history/receive/',
              data: JSON.stringify(post_data)
              dataType: 'json',
              contentType: 'application/json',
              success: (response) ->
                data = response
#                data = JSON.parse(response)

                histories = []
                i = 0
                for d, i in data
                  histories[i] = new HistoryObject(d)
                layout = new Layout(histories)
                layout.loaded(true)
                layout.drawArticles()

              ,
              error: (xhr, type) ->
                layout = new Layout({})
                layout.loaded(false)
                console.log 'AjaxError:', xhr, type
              )
            ) post_data, keywords, date, cluster_num

    )

