library(dplyr)

births = lapply(list.files("data-raw", pattern = "^nat-.*.bz2", full.names = TRUE), function(filename) {
  D = read.table(bzfile(filename), stringsAsFactors = FALSE)
  #
  names(D) <- c("year", "month", "dow", "sex")
  #
  # Male   = 1
  # Female = 2
  #
  mutate(D,
         month = factor(month, levels = 1:12, labels = month.abb),
         dow = factor(dow, levels = 1:7, labels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")),
         #
         # Need to start with M as first level because in some years the data are encoded as 1 = M and 2 = F.
         #
         sex = factor(sex, labels = c("M", "F")),
         #
         # Now relevel so that F is first.
         #
         sex = relevel(sex, "F")
  )
})

births = do.call(rbind, births)

births = group_by(births, year, month, dow, sex) %>% summarise(count = n()) %>% data.frame

devtools::use_data(births, overwrite = TRUE)
