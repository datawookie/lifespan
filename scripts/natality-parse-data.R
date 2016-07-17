library(dplyr)

births = lapply(list.files("data-raw", pattern = "^nat-.*.bz2", full.names = TRUE), function(filename) {
  D = read.table(bzfile(filename), stringsAsFactors = FALSE)
  #
  names(D) <- c("year", "month", "dow", "sex")
  #
  mutate(D,
         month = factor(month, levels = 1:12, labels = month.abb),
         dow = factor(dow, levels = 1:7, labels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")),
         #
         # In earlier years the data are encoded as 1 = M and 2 = F.
         #
         sex = factor(sex, levels = if(class(sex) == "integer") c(2, 1) else c("F", "M"), labels = c("F", "M"))
  )
})

births = bind_rows(births)

births = group_by(births, year, month, dow, sex) %>% summarise(count = n()) %>% data.frame

devtools::use_data(births, overwrite = TRUE)
