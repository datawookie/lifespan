#' Survival Probability
#' 
#' @param x Age.
#' @param t Number of years survived beyond current age.
#' @param k Die within this many years.
#'   
#' If k is not specified then the function will return the probability that a
#' person aged x will live for at least another t years (they will live up to
#' at least age x+t).
#' 
#' If a value for k is given then the function will return the probability
#' that a person aged x will live for at least another t years but then die
#' within the following k years.
#' @import dplyr
#' @import tidyr
#' @examples 
#' survival(70, 5)
#' survival(70, 5, 10)
#' @export
survival <- function(x, t = 1, k = NA) {
  if (is.na(k)) {
    probabilities = lifetable[lifetable$x %in% c(x, x + t),] %>%
      group_by(sex) %>%
      summarise(ratio = lx[2] / lx[1])
  } else {
    probabilities = lifetable[lifetable$x %in% c(x, x + t, x + t + k),] %>%
      group_by(sex) %>%
      summarise(ratio = (lx[2] - lx[3]) / lx[1])
  }
  #
  probabilities %>% spread(sex, ratio) %>% unlist
}
