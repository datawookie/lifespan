library(dplyr)
library(tidyr)

#' Generate a life table.
#' 
#' @param mortality A data frame with columns age and count.
#' @param normalise Initial population in life table.
lifetable.gender <- function(mortality, normalise = 100000) {
  mortality = mortality %>% data.frame %>% rbind(list(max(.$x) + 1, 0)) %>%
    mutate(
      dx = normalise * dx / sum(dx),
      lx = sum(dx) - lag(cumsum(dx), default = 0),
      qx = 1 - lead(lx) / lx
    )
  #
  mortality
}

# Aggregate to age and sex.
# Ensure same max age for both genders.
#
mortality = rename(deathsage, x = age) %>%
  group_by(x, sex) %>%
  summarise(dx = sum(count)) %>%
  spread(sex, dx, fill = 0) %>%
  data.frame %>%
  rbind(data.frame(x = setdiff(1:max(.$x), .$x), F = 0, M = 0)) %>%
  arrange(x) %>%
  gather(sex, dx, -x)
#
lifetable <- rbind(
  lifetable.gender(subset(mortality, sex == "M", select = -sex)) %>% mutate(sex = "M"),
  lifetable.gender(subset(mortality, sex == "F", select = -sex)) %>% mutate(sex = "F")
) %>% select(x, sex, lx, dx, qx)
#
rm(mortality)
#
devtools::use_data(lifetable, overwrite = TRUE)
