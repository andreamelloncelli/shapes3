#' mtcars do
#'
#' @param data
#'
#' @return
#' @export
#'
#' @import dplyr
#'
sel_filter <- function(data) {
  data %>%
    select(mpg,cyl) %>%
    filter(cyl == 6)
}
