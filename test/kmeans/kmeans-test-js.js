var data = [{'y': 4, 'x': 6}, {'y': 4, 'x': 4}, {'y': 9, 'x': 8}, {'y': 1, 'x': 3}, {'y': 3, 'x': 3}, {'y': 10, 'x': 3}, {'y': 5, 'x': 3}, {'y': 10, 'x': 8}, {'y': 7, 'x': 4}, {'y': 6, 'x': 1}, {'y': 2, 'x': 9}, {'y': 7, 'x': 4}, {'y': 6, 'x': 8}, {'y': 4, 'x': 6}, {'y': 4, 'x': 4}, {'y': 3, 'x': 1}, {'y': 7, 'x': 3}, {'y': 1, 'x': 7}, {'y': 3, 'x': 2}, {'y': 2, 'x': 1}];
var kmeans = new Kmeans(data, 4);
var objs = kmeans.start();
var colors = {0:'pink', 1:'red', 2:'yellow', 3:'blue'};
//
//var test = function
//d3.select("body")
//    .selectAll("p")
//    .data(data)
//    .enter()
//    .append("p")
//    .text("新しいパラグラフ！");
//
