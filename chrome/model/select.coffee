histories = []

$ ->
  $('#submit').on 'click', (e)->
    selected = []
    unselected = []
    histories = $('.article .article-inner')
    for history in histories
      visit = history.children[0].getAttribute('data-visit')
      keyword = history.children[0].getAttribute('data-keyword')
      title = history.children[1].innerHTML
      content = history.children[2].innerHTML.length
      o = {"visit": visit, "keyword": keyword, "title": title, "content": content}
      if history.className.indexOf('selected') < 0
        unselected.push(o)
      else
        selected.push(o)
    post_data = {"selected":selected, "unselected": unselected}

    $.ajax (
      type: 'post',
      url: 'http://0.0.0.0:5000/history/selected/',
      data: JSON.stringify(post_data)
      dataType: 'json',
      contentType: 'application/json',
      success: (response) ->
        console.log "success"
      ,
      error: (xhr, type) ->
        console.log 'AjaxError:', xhr, type
    )


class @History
  changeDate: (date, cluster_num, tech_type, searchWord = "")->
    start = Date.parse(date)
    end = Date.parse(date) + 86400000

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
        ((post_data, keywords, date, cluster_num, tech_type) ->
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
              'keywords': keywords,
              'cluster_num': cluster_num,
              'tech_type': tech_type
            }

            console.log post_data

            $.ajax (
              type: 'post',
              url: 'http://0.0.0.0:5000/history/select/',
              data: JSON.stringify(post_data)
              dataType: 'json',
              contentType: 'application/json',
              success: (response) ->
                layout = new Layout({})
                layout.loaded(true)

                data = response
                for cluster in data
                  $('#main-container').append("<hr>")

                  for page in cluster
                    console.log page.keyword_count, page
                    html = '<div class="article" style="position:relative; width: 400px; height:400px; display: inline-block; vertical-align: top;">' +
                        '<div class="article-inner">' +
                        "<p data-keyword=\"" + page.keyword_count + "\" data-visit=\"" + page.visit_count + "\">" +
                        '<h4>' + page.title + '</h4>' +
                        '<div>' + page.content[0..500] + '</div>' +
                        '</div>' +
                        '</div>'
                    $('#main-container').append(html)

                $('.article-inner').on 'click', (e)->
                  $(this).toggleClass('selected')
                  console.log e


              ,
              error: (xhr, type) ->
                layout = new Layout({})
                layout.loaded(false)
                console.log 'AjaxError:', xhr, type
            )) post_data, keywords, date, cluster_num, tech_type
    )

