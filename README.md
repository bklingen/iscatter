# iscatter
Interactive plotly scatterplots with rhandsontable in the ui

## Goals: 

- [ ] Build in latency/delay when the hover event is triggered.
- [ ] Adding/removing multiple traces corresponding to subgroups.
- [x] Hover and click events in scatterplot (such as adding or deleting points)
- [x] Row highlighting and focusing in rhandsontable

## Installation on Linux:

### Prerequisites

[`libv8`](https://developers.google.com/v8/intro) is a Javascript engine that is needed to install the R package `V8`. You will need 3.14 or 3.15 (no newer!). On __Debian__ or __Ubuntu__ use [libv8-3.14-dev](https://packages.debian.org/testing/libv8-3.14-dev):

```
sudo apt-get install -y libv8-3.14-dev
```

Row highlighting works with v0.3.4.3 of `rhandsontable`, but not necessarily with newer ones. Here's how you get this specific version:
```r
devtools::install_github("jrowen/rhandsontable", ref = "55f7a3c67d71a5c0697fc4be3639229d9a0891f7")
```

### The package

```
devtools::install_github("bklingen/iscatter")
```
