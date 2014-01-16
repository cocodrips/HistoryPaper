var draw_treemap = function(dataset){
    var extend = 1;
    var bgcolor = "#F5F5F5";
    var bordercolor = "#fff";

//    reset
    $("#main-container").text("");

    var w = $(window).width()- sidebarWidth,
        h = $(window).height() - headerHeight,
        x = d3.scale.linear().range([0, w]),
        y = d3.scale.linear().range([0, h]),
        color = d3.scale.category20c(),
        root,
        node;

    var treemap = d3.layout.treemap()
        .round(false)
        .size([w, h])
        .sticky(true)
        .mode("squarify")
        .value(function(d) { return d.size; });

//  #treemap使ってない
    var svg = d3.select("#treemap").append("div")
        .attr("class", "chart")
        .style("width", w*extend + "px")
        .style("height", h + "px")
        .append("svg:svg")
        .attr("width", w*extend)
        .attr("height", h)
        .append("svg:g")
        .attr("transform", "translate(.5,.5)");

    node = root = dataset;
    var count = 0;

    var nodes = treemap.nodes(root)
        .filter(function(d) { return !d.children; });

    var cell = svg.selectAll("g")
        .data(nodes)
        .enter().append("svg:g")
        .attr("class", "cell")
        .attr("transform", function(d) { return "translate(" + d.x*extend + "," + d.y + ")"; })
        .on("click", function(d) { return zoom(node == d.parent ? root : d.parent); });

    var rect = cell.append("svg:rect")
        .attr("width", function(d) { return d.dx * extend - 1; })
        .attr("height", function(d) { return d.dy - 1; })
        .attr("stroke", bordercolor)
        .style("fill", bgcolor)
        .attr("stroke-width",10);

    cell.append("svg:text")
        .attr("x", function(d) { return d.dx * extend / 2; })
        .attr("y", function(d) { return d.dy / 2; })
        .attr("dy", ".35em")
        .attr("text-anchor", "middle")
        .text(function(d) { return d.name; })
        .style("opacity", function(d) { d.w = this.getComputedTextLength(); return d.dx > d.w ? 1 : 0; });

//    var id_name = function(d) { return d.parent.name;};
    var id_name = function(d) { return d.articleId;};
    var width = function(d) {
        return d.dx * extend - 1 +"px";
    };
    var height = function(d) { return (d.dy - 1)+"px";};


    var allRect = cell.selectAll("rect")
        .append("div")
        .text(function(d) { return d.name; })
        .attr("id", id_name)
        .attr("class", "branches")
        .style("width", function(d) { return d.dx * extend - 1; })
        .style("height", function(d) { return d.dy - 1; })
        .style("background-color", "black");


//    同じ座標にdivを追加
    var article = d3.select("#main-container")
        .selectAll("div")
        .data(nodes)
        .enter()
        .append("div")
        .attr("class","article")
        .style("width", width)
        .style("height", height)
        .style("left", function(d) { return d.x*extend+"px"})
        .style("top", function(d) { return d.y+"px"})
        .append("div")
        .attr("class","article-inner")

    article.append("h2")
        .html(function(d) { return "<a href="+d.url+" target='_blank'>"+d.name+"</a>"});
//    article.append("h5")
//        .html(function(d) { return "<a href="+d.url+" target='_blank'>"+d.url+"</a>"});
    article.append("div")
        .attr("class", "news-img")
        .html(function(d) {return "<img src= " +d.image + ">"});
    article.append("div")
        .attr("class", "news-text")
        .html(function(d) {return d.summary});


    d3.select(window).on("click", function() { zoom(root); });

    d3.select("select").on("change", function() {
        treemap.value(this.value == "size" ? size : count).nodes(root);
        zoom(node);
    });


    function size(d) {
        return d.size;
    }

    function count(d) {
        return 1;
    }

    function zoom(d) {
//        ズームアップ
//        var article = $('#main_article');
//        if(d.children.length <= 1){
//            article.attr('src', d.children[0].url)
//            console.log(d.children[0].url);
//            article.css('height', ($(window).height() - 138)+"px" );
//            setTimeout(function(){
//                article.css('display', 'block');
//
//            },500);
//        }else{
//            setTimeout(function(){
//                article.css('display', 'none');
//            },500);
//        }
//
//        var kx = w * extend / d.dx, ky = h / d.dy;
//        x.domain([d.x * extend, d.x * extend + d.dx* extend]);
//        y.domain([d.y, d.y + d.dy]);
//
//        var t = svg.selectAll("g.cell").transition()
//            .duration(d3.event.altKey ? 7500 : 750)
//            .attr("transform", function(d) { return "translate(" + x(d.x * extend)* extend + "," + y(d.y) + ")"; });
//
//        var rect = t.select("rect")
//            .attr("width", function(d) { return kx * d.dx  - 1; })
//            .attr("height", function(d) { return ky * d.dy - 1; })
//
//
//        t.select("text")
//            .attr("x", function(d) { return kx * d.dx / 2; })
//            .attr("y", function(d) { return ky * d.dy / 2; })
//            .style("opacity", function(d) { return kx * d.dx * extend > d.w ? 1 : 0; });
//
//        node = d;
//        d3.event.stopPropagation();


    }
};


