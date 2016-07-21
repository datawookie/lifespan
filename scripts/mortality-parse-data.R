library(dplyr)

deaths = lapply(list.files("data-raw", pattern = "^mort-.*.bz2", full.names = TRUE), function(filename) {
  D = read.table(bzfile(filename), stringsAsFactors = FALSE)
  #
  names(D) <- c("year", "month", "dow", "age", "sex")
  #
  mutate(D,
         month = factor(month, levels = 1:12, labels = month.abb),
         dow = factor(dow, levels = 1:7, labels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")),
         #
         # If age == 999 then it is missing; otherwise
         # If age >= 200 then it is less than one year.
         #
         age = ifelse(age >= 200, 0, ifelse(age == 999, NA, age)),
         #
         # In earlier years the data are encoded as 1 = M and 2 = F.
         #
         sex = factor(sex, levels = if(class(sex) == "integer") c(2, 1) else c("F", "M"), labels = c("F", "M"))
  )
})

deaths = bind_rows(deaths)

deathsage = group_by(deaths, year, age, sex) %>% summarise(count = n())

deaths = group_by(deaths, year, month, sex) %>% summarise(
  count = n(),
  avgage = mean(age),
  medage = median(age),
  maxage = max(age)
  ) %>% data.frame
#
devtools::use_data(deaths, overwrite = TRUE)
devtools::use_data(deathsage, overwrite = TRUE)