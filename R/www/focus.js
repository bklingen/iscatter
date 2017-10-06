$(document).ready(function() {
    console.log("ready!");
    var mytable =  HTMLWidgets.getInstance(document.querySelector('div#table')).hot;
    mytable.selectCell(30, 1);
    mytable.deselectCell();
});