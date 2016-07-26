library(dplyr)
library(tidyr)

#' Generate a life table.
#' 
#' @param mortality A data frame with columns age and count.
#' @param normalise Initial population in life table.
lifetable.gender <- function(mortality, normalise = 100000) {
  mortality = mortality %>% data.frame %>% rbind(list(max(.$age) + 1, 0)) %>%
    mutate(
      dx = normalise * dx / sum(dx),
      lx = sum(dx) - lag(cumsum(dx), default = 0)
    ) %>%
    select(age, lx, dx)
  #
  mortality
}

# Aggregate to age and sex.
# Ensure same max age for both genders.
#
mortality = group_by(deathsage, age, sex) %>%
  summarise(dx = sum(count)) %>%
  spread(sex, dx, fill = 0) %>%
  gather(sex, dx, -age)
#
lifetable <- rbind(
  lifetable.gender(subset(mortality, sex == "M", select = -sex)) %>% mutate(sex = "M"),
  lifetable.gender(subset(mortality, sex == "F", select = -sex)) %>% mutate(sex = "F")
)
#
rm(mortality)
#
devtools::use_data(lifetable, overwrite = TRUE)
