function highlight(instance, td, row, col, prop, value, cellProperties) {
  Handsontable.TextCell.renderer.apply(this, arguments);
    td.style.color = 'black'; 
    if (instance.params) {
      hrows = instance.params.hovered;
      hrows = hrows instanceof Array ? hrows : [hrows];
    }
    if (instance.params && hrows.includes(row)) td.style.background = 'lightcoral';
}