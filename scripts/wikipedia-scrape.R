library(rvest)
library(dplyr)
library(plotly)
library(stringr)

population <- read_html("http://bit.ly/29Qqzm3") %>% html_nodes("table") %>% .[[1]] %>% html_table(trim = TRUE)
#
population <- population[, c(2:3, 6)]
names(population) <- c("country", "region", "population")
population <- mutate(population,
                     country = str_replace_all(country, "(^[^[:alpha:]]*|\\[.\\]$)", "")
)

expectancy <- read_html("http://bit.ly/1LjieDy") %>% html_nodes("table") %>% .[[1]] %>% html_table(trim = TRUE)
#
expectancy <- expectancy[, c(1, 5, 7)]
names(expectancy) <- c("country", "female", "male")
expectancy <- mutate(expectancy,
                     country = str_replace(country, "^[^[:alpha:]]*", "")
)

expectancy = merge(population, expectancy) %>% mutate(
  country = factor(country),
  region = factor(region),
  population = as.numeric(gsub(",", "", population))
)

rm(population)

expectancy.plot <- plot_ly(expectancy, x = male, y = female,
                           color = region,
                           size = population,
                           mode = "markers",
                           hoverinfo = "text",
                           text = country) %>%
  add_trace(x = c(45, 90), y = c(45, 90), mode = "lines",
            line = list(
              color = "rgba(60, 60, 60, 0.5)",
              dash = "dashed",
              width = 0.5
            ), showlegend = FALSE) %>%
  layout(
    xaxis = list(title = "Male Life Expectancy [years]"),
    yaxis = list(title = "Female Life Expectancy [years]")
  )

plotly_POST(expectancy.plot, filename = "life-expectancy-by-country")
