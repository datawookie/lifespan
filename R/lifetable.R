#' Life Table
#'
#' Cohort life tables for each gender derived from CDC data.
#'
#' @format A data frame:
#' \describe{
#'   \item{x}{Age in years.}
#'   \item{sex}{Gender.}
#'   \item{lx}{The number of people who survive to age x from an initial cohort of 100 000.}
#'   \item{dx}{The expected number of people from the initial cohort who die aged x on their last birthday.}
#'   \item{qx}{The probability that a person aged x will die before reaching age x+1.}
#' }
#' @source Data gathered from http://www.cdc.gov/. Subsequently summarised.
"lifetable"