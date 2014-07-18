data = []

class @History
  changeDate: (date, searchWord = "")->
    start = Date.parse(date) - 86400000;
    end = Date.parse(date);
    jsonData = ""
    histories = []

    query = {
      "text": searchWord,
      "startTime": start,
      "endTime": end,
      "maxResults": 1000
    }
    chrome.history.search(query, (array)=>
      searchWordList(array)
      post_data = {}
      urls = (a['url']for a in array)
      for a in array
        if a['url'].indexOf("https") == -1
          post_data[a['url']] = {
            'id': a['id']
            'title': a['title'],
            'content': '',
            'url': a['url'],
            'visitCount': a['visitCount']
          }

      chrome.storage.local.get urls,
        ((post_data) ->
          (items) ->
            for key, value of items
              if key.indexOf("https") == -1
                post_data[key]['content'] = value

            post_data = (data for data in _.values(post_data) when data['content']!= '')

            $.ajax (
              type: 'post',
              url: 'http://127.0.0.1:8000/historypaper/receive/',
              data: JSON.stringify(post_data)
              dataType: 'json',
              success: (response) ->
                data = JSON.parse(response)
                console.log data

                histories = []
                i = 0
                for d, i in data
                  histories[i] = new HistoryObject(d)
                layout = new Layout(histories)
                layout.drawArticles()
              ,
              error: (xhr, type) ->
                console.log 'AjaxError:', xhr, type
            )) post_data
    )


test_data = [
  ["Android wear", "http://www.android.com/wear/",
   "Small, powerful devices, worn on the body. Useful information when you need it most. Intelligent answers to spoken questions. Tools to help reach fitness goals. Your key to a multiscreen world. The Android Wear Developer Preview lets you create wearable…",
   "https://i1.ytimg.com/vi/0xQ3y902DEQ/maxresdefault.jpg"],
  ["8.3. collctions — High-performance container datatypes", "https://docs.python.org/2/library/collections.html",
   "indexmodules |next |previous | Python »   Documentation » The Python Standard Library » 8. Data Types » 8.3. collections — High-performance container datatypes New in version 2.4.  Source code: Lib/collections.py and Lib/_abcoll.py  This module implements specialized container datatypes providing alternatives to Python’s general purpose built-in containers, dict, list, set, and tuple.  namedtuple()	factory function for creating tuple subclasses with named fields	 New in version 2.6. deque	list-like container with fast appends and pops on either end	 New in version 2.4. Counter	dict subclass for counting ..."],
  ["Android TV", "http://www.android.com/tv/",
   "Entertainment tailored for you. Keep me posted    By submitting your email, you acknowledge that your information will be used in accordance with Google’s Privacy Policy.  A world of content and games Watch hit shows, timeless movies, and viral videos from Google Play, YouTube, and your favorite apps like Netflix. Android games shine on your HDTV with a gamepad.  Available on Google Play: Batman Begins, Man of Steel, The LEGO Movie, The Hobbit: The Desolation of Smaug  Less browsing, more watching Discover personalized recommendations right on your home screen. No more endless digging through your channel guide"],
  ["D3.js - Data-Driven Documents", "http://d3js.org/",
   "Overview Examples Documentation Source Data-Driven Documents See more examples. D3.js is a JavaScript library for manipulating documents based on data. D3 helps you bring data to life using HTML,",
   "http://d3js.org/preview.png"],
  ["Google I/O 2014", "https://www.google.com/events/io", "Thanks for joining us today.
    We’ll be back in the morning with more sessions from I/O Live.
    Check the schedule for more information.
    See I/O in action
    We’re capturing the best moments throughout the conference and posting them right here.
    Previous Next
    Get the latest
    Stay up to date as the conference unfolds on the +Google Developers page.
     Got questions? Ask us on Google+ using #io14request

    Google Developers
    6 hours ago
    Google Design, in IO Bytes Form
    #io14   #design   #iobytes
    With Google’s new Material Design language, we’ve produced  lots of great new design focused videos in this convenient playlist. ﻿"],

  ["AngularJS — Superheroic JavaScript MVW Framework", "https://angularjs.org/",
   "HTML enhanced for web apps!  View on GitHub Download (1.2.18 / 1.3.0-beta.13) Follow +AngularJS on Learn Angular ..."],
  ["Floyd–Warshall algorithm", "http://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm",
   """  "Floyd's algorithm" redirects here. For cycle detection, see Floyd's cycle-finding algorithm. For computer graphics, see Floyd–Steinberg dithering.
   Floyd–Warshall algorithm
   Class  All-pairs shortest path problem (for weighted graphs)
   Data  ..."""],
  ["25 Outstanding Magazine Style Website Designs | Vandelay Design",
   "http://vandelaydesign.com/blog/galleries/magazine-style-website/",
   "One of my favorite styles of web design to take ..."],
  ["Natural Language Toolkit &mdash; NLTK 3.0 documentation", "http://www.nltk.org/",
   "NLTK is a leading platform for building Python programs to work with human language data. It provides easy-to-use ..."],
  ["10 Lessons in Treemap Design | SmartData Collective", "http://smartdatacollective.com/Home/16512",
   "In the information visualization world, treemaps are on the rise…and justifiably so. Treemaps simultaneously show ..."],
]

test_rect = [
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
  data[i].rect = new Rect(test_rect[i][0], test_rect[i][1], test_rect[i][2], test_rect[i][3])
  data[i].title = test_data[i][0]
  data[i].url = test_data[i][1]
  data[i].content = test_data[i][2]
  data[i].imageurl = test_data[i][3]