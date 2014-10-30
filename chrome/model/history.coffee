histories = []

class @History

  changeDate: (date, searchWord = "")->
    start = Date.parse(date) - (86400000 * 2)
    end = Date.parse(date) - 86400000

    query = {
      "text": searchWord,
      "startTime": start,
      "endTime": end,
      "maxResults": 1000
    }
    chrome.history.search(query, (array)=>
      keywords = searchWordList(array)
      post_data = {}
      urls = (a['url'] for a in array)
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
        ((post_data, keywords, date) ->
          (items) ->
            for key, value of items
              if key.indexOf("https") == -1
                post_data[key]['content'] = value

            post_data = (data for data in _.values(post_data) when data['content'] != '')
            post_data = {'data': post_data, 'date': date, 'width': window.innerWidth - 380, 'height': window.innerHeight - 150, 'keywords':keywords}
#            post_data = {'data': post_data, 'width': 1000, 'height': 500}

#            console.log "post:", post_data
#
#            console.log histories
#            layout = new Layout(histories)
#            layout.drawArticles()

            $.ajax (
              type: 'post',
#              url: 'http://0.0.0.0:8080/historypaper/receive/',
#              url: 'http://0.0.0.0:5000/history/receive/',
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
                layout.loaded()
                layout.drawArticles()

              ,
              error: (xhr, type) ->
                layout = new Layout({})
                layout.loaded()
                console.log 'AjaxError:', xhr, type
              )
            ) post_data, keywords, date

    )



test_data = [
  ["10 Lessons in Treemap Design | SmartData Collective", "http://smartdatacollective.com/Home/16512",
   "In the information visualization world, treemaps are on the rise…and justifiably so. Treemaps simultaneously show the big picture, comparisons of related items, and allow easy navigation to the details.

   However, treemaps aren’t easy to get right. In contrast to basic charts where Stephen Few, Edward Tufte, and the Chart Chooser have laid down the law, treemaps roam the Wild West of interface design, obeying few rules, breaking many, and contributing to much infovis lawlessness.

   Over the last year or so we’ve been building treemaps for our clients using our (recently open-sourced) Flex-based JuiceKit™ SDK. Over the course of these projects, we’ve thought a lot about the best way to make treemaps easy to understand and use. I won’t claim we have “cracked the code,” but we have gotten a feel for what works and what doesn’t. I want to share some examples of the good and the bad in treemap design, and hopefully gather some feedback so we can continue to evolve our thinking.

   1. Choose the right measures for size and color

   Each box in a treemap can show two measures:

   Size of the boxes should be a quantity measure. The measures should sum up along the hierarchical structure of the data. The sum of all the elements in one branch need to sum to the value of the branch as a whole. Therefore, you can’t use ratios or dates or any other measure you wouldn’t use in a pie chart.
   Color of the boxes is best suited to a measure of performance or change such as growth over time, average conversion rate, or customer satisfaction.
   ", "http://media.juiceanalytics.com/images/map_of_the_market.png"],
  ["Android TV", "http://www.android.com/tv/",
   "Entertainment tailored for you. Keep me posted    By submitting your email, you acknowledge that your information will be used in accordance with Google’s Privacy Policy.  A world of content and games Watch hit shows, timeless movies, and viral videos from Google Play, YouTube, and your favorite apps like Netflix. Android games shine on your HDTV with a gamepad.  Available on Google Play: Batman Begins, Man of Steel, The LEGO Movie, The Hobbit: The Desolation of Smaug  Less browsing, more watching Discover personalized recommendations right on your home screen. No more endless digging through your channel guide",
  "http://www.android.com/new/images/tv/smarter-2.jpg"],
  ["D3.js - Data-Driven Documents", "http://d3js.org/",
   "Overview Examples Documentation Source
    Data-Driven Documents

   See more examples.
   D3.js is a JavaScript library for manipulating documents based on data. D3 helps you bring data to life using HTML, SVG and CSS. D3’s emphasis on web standards gives you the full capabilities of modern browsers without tying yourself to a proprietary framework, combining powerful visualization components and a data-driven approach to DOM manipulation.

   Download the latest version (3.4.11) here:

   d3.zip
   Or, to link directly to the latest release, copy this snippet:
",
   "http://d3js.org/preview.png"],
  ["8.3. collctions — High-performance container datatypes", "https://docs.python.org/2/library/collections.html",
   "indexmodules |next |previous | Python »   Documentation » The Python Standard Library » 8. Data Types »
      8.3. collections — High-performance container datatypes
      New in version 2.4.

      Source code: Lib/collections.py and Lib/_abcoll.py

      This module implements specialized container datatypes providing alternatives to Python’s general purpose built-in containers, dict, list, set, and tuple.

      namedtuple()	factory function for creating tuple subclasses with named fields
      New in version 2.6.
      deque	list-like container with fast appends and pops on either end
      New in version 2.4.
      Counter	dict subclass for counting hashable objects
      New in version 2.7.
      OrderedDict	dict subclass that remembers the order entries were added
      New in version 2.7.
      defaultdict	dict subclass that calls a factory function to supply missing values
      New in version 2.5.
      In addition to the concrete container classes, the collections module provides abstract base classes that can be used to test whether a class provides a particular interface, for example, whether it is hashable or a mapping.

      8.3.1. Counter objects
      A counter tool is provided to support convenient and rapid tallies. For example:

      >>>
      >>> # Tally occurrences of words in a list
      >>> cnt = Counter()
      >>> for word in ['red', 'blue', 'red', 'green', 'blue', 'blue']:
      ...     cnt[word] += 1
      >>> cnt
      Counter({'blue': 3, 'red': 2, 'green': 1})

      >>> # Find the ten most common words in Hamlet
      >>> import re
      >>> words = re.findall(r'\w+', open('hamlet.txt').read().lower())
      >>> Counter(words).most_common(10)
      [('the', 1143), ('and', 966), ('to', 762), ('of', 669), ('i', 631),
       ('you', 554),  ('a', 546), ('my', 514), ('hamlet', 471), ('in', 451)]
      class collections.Counter([iterable-or-mapping])
      A Counter is a dict subclass for counting hashable objects. It is an unordered collection where elements are stored as dictionary keys and their counts are stored as dictionary values. Counts are allowed to be any integer value including zero or negative counts. The Counter class is similar to bags or multisets in other languages.
      "],
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
   "HTML enhanced for web apps!
    View on GitHub    Download (1.2.26 / 1.3.0)
   Follow +AngularJS on
   Learn Angular in your browser for free!

   October 22nd-23rd, 2014
   Join us in Paris, France in October for the first official AngularJS European conference.

   Buy Tickets More Info...
   Why AngularJS?

   HTML is great for declaring static documents, but it falters when we try to use it for declaring dynamic views in web-applications. AngularJS lets you extend HTML vocabulary for your application. The resulting environment is extraordinarily expressive, readable, and quick to develop.

   Alternatives

   Other frameworks deal with HTML’s shortcomings by either abstracting away HTML, CSS, and/or JavaScript or by providing an imperative way for manipulating the DOM. Neither of these address the root problem that HTML was not designed for dynamic views.

   Extensibility

   AngularJS is a toolset for building the framework most suited to your application development. It is fully extensible and works well with other libraries. Every feature can be modified or replaced to suit your unique development workflow and feature needs. Read on to find out how.
   "],
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
  ["Android wear", "http://www.android.com/wear/",
   "Small, powerful devices, worn on the body. Useful information when you need it most. Intelligent answers to spoken questions. Tools to help reach fitness goals. Your key to a multiscreen world. The Android Wear Developer Preview lets you create wearable…",
   "https://i1.ytimg.com/vi/0xQ3y902DEQ/maxresdefault.jpg"]
]

#test_rect = [
#  [0, 0, 510, 464] ,
#  [510, 0, 445, 421.052631579] ,
#  [510, 421.052631579, 445, 368.421052632] ,
#  [955, 0, 445, 421.052631579] ,
#  [955, 421.052631579, 445, 368.421052632] ,
#  [0, 464, 510, 178] ,
#  [510, 789.473684211, 445, 210.526315789] ,
#  [955, 789.473684211, 445, 210.526315789] ,
#  [0, 642, 510, 178] ,
#  [0, 820, 510, 178] ,
#]
#

#treemap
test_rect = [
  [1067, 0, 432, 999],
  [471, 484, 595, 515],
  [471, 0, 595, 483],
  [173, 355, 297, 644],
  [173, 0, 297, 354],
  [0, 445, 172, 554],
  [0, 167, 172, 277],
  [0, 56, 172, 110],
  [0, 0, 172, 55]
]

#proporsal
#test_rect = [
##  [0, 0, 680, 619],
##  [680, 0, 820, 358],
##  [680, 358, 820, 358],
##  [680, 716, 610, 283],
##  [0, 619, 519, 190],
##  [0, 809, 519, 190],
##  [1290, 716, 210, 283],
##  [519, 619, 160, 190],
##  [519, 809, 160, 190]
#  [0, 0, 618, 684],
#  [618, 0, 618, 471],
#  [618, 471, 618, 471],
#  [0, 684, 618, 316],
#  [1236, 391, 264, 391],
#  [1236, 0, 264, 391],
#  [1236, 782, 264, 217],
#  [618, 943, 309, 57],
#  [927, 943, 309, 57],
#]

for i in [0..8]
  o = {}
  o['rect'] = test_rect[i]
  o['title'] = test_data[i][0]
  o['url'] = test_data[i][1]
  o['content'] = test_data[i][2]
  o['image_url'] = test_data[i][3]
  histories[i] = new HistoryObject(o)

