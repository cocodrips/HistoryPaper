@headerHeight = 38;
@sidebarWidth = 300;

$ ->
  mainHeight = $(window).height() - headerHeight
  $("#main-container").css("height", mainHeight)
  $("#sidebar").css("height", mainHeight)
  newstext = $(".news-text").html();
  console.log newstext

