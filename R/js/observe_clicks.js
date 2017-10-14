shinyjs.observe_clicks = function(params) {
  var name = params[0];
  var selector = "div.plotly#" + name;
  var gd = $(selector)[0];
  
  var xaxis = gd._fullLayout.xaxis;
  var yaxis = gd._fullLayout.yaxis;
  var margin = gd._fullLayout.margin;
  var offsets = gd.getBoundingClientRect();

  var xy1 = gd.layout.xaxis.range[0];
  var xy2 = gd.layout.xaxis.range[1];
  var xx1 = offsets.left + margin.l;
  var xx2 = offsets.left + gd.offsetWidth - margin.r;
  var mx = (xy2 - xy1) / (xx2 - xx1);
  var cx = -(mx * xx1) + xy1;

  var yy1 = gd.layout.yaxis.range[0];
  var yy2 = gd.layout.yaxis.range[1];
  var yx1 = offsets.top + gd.offsetHeight - margin.b;
  var yx2 = offsets.top + margin.t;
  var my = (yy2 - yy1) / (yx2 - yx1);
  var cy = -(my * yx1) + yy1;

  gd.addEventListener('click', function(evt) {
    var xInDataCoord = mx*evt.x + cx;
    var yInDataCoord = my*evt.y + cy;
    
    Shiny.onInputChange("clicked", [xInDataCoord, yInDataCoord]);
  });
};