shinyjs.focus = function(params) {
  var name = params[0];
  var row = params[1];
  var max = params[2];
  var selector = "div.rhandsontable" + "#" + name;
  var table = HTMLWidgets.getInstance(document.querySelector(selector)).hot;
  table.selectCell(max, 1);
  table.selectCell(row-2, 1);
  table.deselectCell();
};