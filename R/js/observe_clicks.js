shinyjs.observe_clicks = function(params) {
  var name = params[0];
  var selector = "div.plotly#" + name;
  var gd = $(selector)[0];
  
  var xaxis = gd._fullLayout.xaxis;
  var yaxis = gd._fullLayout.yaxis;
  var l = gd._fullLayout.margin.l;
  var t = gd._fullLayout.margin.t;
  
  gd.addEventListener('click', function(evt) {
    var xInDataCoord = xaxis.p2c(evt.x - l);
    var yInDataCoord = yaxis.p2c(evt.y - t);
    
    console.log([xInDataCoord, yInDataCoord]);
    
    Shiny.onInputChange("clicked", [xInDataCoord, yInDataCoord]);
  });
};