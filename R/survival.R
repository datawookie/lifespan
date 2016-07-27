#' Survival Probability
#' 
#' @param x Age.
#' @param t Number of years survived beyond current age.
#' @param k Die within this many years.
#'   
#' If k is not specified then the function will return the probability that a
#' person aged x will live for at least another t years (they will live up to
#' at least age x+t).
survival <- function(x, t, k = NA) {
  # the probability that someone aged exactly {\displaystyle \,x} \,x will survive for {\displaystyle \,t} \,t more years, then die within the following {\displaystyle \,k} \,k years
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
survival(70, 5)
survival(70, 5, 5)