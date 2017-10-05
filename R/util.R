#' @import tidyverse

moveToTop <- function(x, n) {
  rbind(x[n,,FALSE], x[-n,,FALSE])
}