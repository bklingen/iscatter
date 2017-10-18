# iscatter
Interactive plotly scatterplots with rhandsontable in the ui

## Goals: 

- [ ] Hover and click events in scatterplot (such as adding or deleting points)
- [ ] Adding/removing multiple traces corresponding to subgroups.
- [x] Build in latency/delay when the hover event is triggered.
- [x] Row highlighting and focusing in rhandsontable

## Installation on Linux:

### Prerequisites

[`libv8`](https://developers.google.com/v8/intro) is a Javascript engine that is needed to install the R package `V8`. You will need 3.14 or 3.15 (no newer!). On __Debian__ or __Ubuntu__ use [libv8-3.14-dev](https://packages.debian.org/testing/libv8-3.14-dev):

```
sudo apt-get install -y libv8-3.14-dev
```

Row highlighting works with the newest version of rhandsontable (currently v0.3.4.9), but there is a change in the code for the renderer function. Starting after version 0.3.4.6, one needs to replace ``Handsontable.TextCell.renderer.apply(this, arguments);`` with ``Handsontable.renderers.TextRenderer.apply(this, arguments);``. 

Here's how to install the latest version from github:
```r
devtools::install_github("jrowen/rhandsontable")
```

### The package

```
devtools::install_github("bklingen/iscatter")
```
