/**
 * Focus on a given row of an RHandsontable.
 * 
 * @param {String} params.id
 * ID of the DOM element that contains the RHandsontable
 * 
 * @param {Number} params.hovered
 * Row of interest (0-indexed)
 * 
 * @param {Number} params.last
 * The index of the last row (0-indexed)
 */
 
shinyjs.focus = function(params) {
  // Select the first "div" element with "rhandsontable" class and the given id
  // on the page.
  var selector = "div.rhandsontable" + "#" + params.id;
  var td = document.querySelector(selector);
  
  // Get the widget instance of the DOM element, which is a JavaScript object.
  var widget = HTMLWidgets.getInstance(td);
  
  // Access the field that contains the data about our table.
  var table = widget.hot;
  
  // Rhandsontable select cells in a way that either puts the cell of interest
  // at the top or at the bottom, depending on the direction moved. To make the
  // focusing more consistent, we first go to the last row.
  table.selectCell(params.last, 1);
  
  // Finally, move 2 rows above the row of interest, unless the row of interest
  // is one of the first two.
  params.hovered = params.hovered < 2 ? 2 : params.hovered;
  table.selectCell(params.hovered-2, 1);
  table.deselectCell();
};