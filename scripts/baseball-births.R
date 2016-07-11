library(rvest)
library(dplyr)

month <- data.frame(month = 1:12, length = c(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31))

baseball <- with(month,
                 lapply(1:12, function(m) {
                   lapply(1:length[m], function(d) {
                     URL = sprintf("http://www.baseball-reference.com/friv/birthdays.cgi?month=%d&day=%d", m, d)
                     baseball = read_html(URL) %>% html_nodes("table") %>%
                       .[[1]] %>% html_table() %>%
                       .[,names(.) != ""] %>% mutate(month = m, day = d)
                   })
                 })
)
baseball = unlist(baseball, recursive = FALSE)
baseball = do.call(rbind, baseball)
#
baseball = mutate(baseball,
                  month = factor(month, labels = month.abb)
) %>% select(Name, Year = Born, Month = month, Day = day)

devtools::use_data(baseball, overwrite = TRUE)
