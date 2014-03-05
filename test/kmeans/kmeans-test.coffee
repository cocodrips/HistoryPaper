

@start = () ->
  clusterNum = 5
  elementNum = 100
  data = []
  for i in [0...elementNum]
    obj = {}
    obj.x = Math.floor( Math.random() * elementNum )
    obj.y = Math.floor( Math.random() * elementNum )
    data[i] = obj

  kmeans = new Kmeans(data, clusterNum)
  objs = kmeans.start()
  colors = {0:'pink', 1:'red', 2:'yellow', 3:'blue', 4: 'green'}

  svg = d3.select("body")
    .append("svg")
    .attr("width", 500)
    .attr("height", 500)

  svg.selectAll("circle")
    .data(objs)
    .enter()
    .append("circle")
    .attr("cx", (d) ->
      console.log d
      return d.coordinate['x'] * 3
    )
    .attr("cy", (d) ->
      return d.coordinate['y'] * 3
    )
    .attr("r", 3)
    .attr("fill", (d) ->
      return colors[d.clusterId]
    )