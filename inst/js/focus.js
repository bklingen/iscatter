shinyjs.focus = function(params) {
  var name = params[0];
  var row = params[1];
  var selector = "div.rhandsontable" + "#" + name;
  var table = HTMLWidgets.getInstance(document.querySelector(selector)).hot;
  table.selectCell(row, 1);
  table.deselectCell();
};