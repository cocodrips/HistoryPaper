
var getJsonData = {
  request: function(urls) {
    var req = new XMLHttpRequest();
    console.log(urls);
    url = "http://cocodrips.com/hs/pageinfo/"+  escape(urls);
    console.log(url);
    req.open("GET", url, true);
    req.onload = this.showData_.bind(this);
    req.send(null);
  },

  showData_: function (e) {
      console.log("status " + e.target.status);
      console.log("response " + e.target.responseText);
      res = $.parseJSON(e.target.responseText);
      console.log(res);
      draw_treemap(res)
  }

};

