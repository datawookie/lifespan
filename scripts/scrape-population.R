library(rvest)
library(dplyr)

URL = "http://www.multpl.com/united-states-population/table"

population <- read_html(URL) %>% html_nodes("table") %>% .[[1]] %>%
  html_table(trim = TRUE) %>%
  setNames(c("year", "count")) %>% mutate(
    year = as.integer(gsub(".*, ", "", year)),
    count = as.numeric(gsub(" million$", "", count))
  ) %>% arrange(year)
#
devtools::use_data(population, overwrite = TRUE)