# iscatter
Interactive plotly scatterplots with rhandsontable in the ui

## Goals: 

- [ ] Hover and click events in scatterplot (such as adding or deleting points)
- [x] Row highlighting and focusing in rhandsontable
- [ ] Adding/removing multiple traces corresponding to subgroups

## Notes:

- Row highlighting works with v0.3.4.3 of rhandsontable, but not necessarily with newer ones. Here's how you get this specific version:
```bash
devtools::install_github(repo = "jrowen/rhandsontable", ref = "55f7a3c67d71a5c0697fc4be3639229d9a0891f7")
```