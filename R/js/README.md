## Calling JavaScript functions from the server

We can call JavaScript functions by importing `shinyjs` and injecting our scripts into somewhere in the page, say `mainPanel`, as follows:

```r
library(shinyjs)

mainPanel(useShinyjs(),
          extendShinyjs(script = "js/focus.js"),
          ...
          )
```

JS functions in `shinyjs` are implementated in a way that, when a JS function is called from the server with named arguments, say `js$focus(id = "hot", hovered = 5, last = 42)`, it will call `shinyjs.focus({id : "hot", hovered : 5, last : 42})`. As a result, the JavaScript function that we write must have `shinyjs` prefix in its name, e.g.,

```js
shinyjs.focus = function(params) {...};
```

And similarly, because `shinyjs` converts R arguments into an `Object` with key-value pairs, the function that we write must have a single argument, say `params`, that contain all arguments within as fields. For instance, to get the index of the hovered row, we would have to evaluate `params.hovered` in the JavaScript function. A full example is given below.

```js
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
  // Select the first "div" element with the class "rhandsontable" and the id
  // <name> on the page. 
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
```