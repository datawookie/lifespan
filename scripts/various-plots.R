library(ggplot2)
library(plotly)

month.days <- data.frame(
  month = month.abb,
  days = c(31, 28.25, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
)

group_by(births, year, month, sex) %>% summarise(count = sum(count)) %>%
  dcast(year + month ~ sex) %>% mutate(ratio = M/F) %>%
  ggplot() +
  geom_boxplot(aes(x = year, y = ratio, group = year)) +
  labs(x = "", y = "Monthly Birth Ratio: Boys/Girls") +
  theme_classic() + theme(legend.title = element_blank())
  
group_by(births, year, month, sex) %>% summarise(count = sum(count)) %>%
  merge(month.days) %>%
  mutate(perday = count / days) %>% ggplot() +
  geom_boxplot(aes(x = month, y = perday, fill = sex)) +
  labs(x = "", y = "Births per Day") +
  theme_classic() + theme(legend.title = element_blank())

group_by(births, month) %>% summarise(count = sum(count)) %>%
  merge(month.days) %>%
  mutate(perday = count / days) %>%
  ggplot(aes(x = month, y = perday / 1000)) +
  geom_bar(stat = "identity", fill = "#39A75E") +
  labs(x = "", y = "Total Births per Day [thousands]") +
  theme_classic()

chisq.test(.Last.value$count, p = c(31, 28.25, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),
           rescale.p = TRUE)

ggplot(deaths, aes(x = year, y = avgage)) +
  geom_boxplot(aes(group = year, fill = sex)) +
  facet_wrap(~ sex) +
  labs(x = "", y = "Average Age at Death") +
  theme_minimal() + theme(legend.title = element_blank())

group_by(deaths, sex, month) %>% summarise(count = sum(count)) %>%
  merge(month.days) %>%
  mutate(perday = count / days) %>%
  ggplot(aes(x = month, y = perday / 1000)) +
  geom_bar(aes(fill = sex), stat = "identity", position = "dodge") +
  labs(x = "", y = "Total Deaths per Day [thousands]") +
  theme_minimal() + theme(legend.title = element_blank())

NYEARS = length(unique(deaths$year))
#
ggplot(deathsage, aes(x = age, y = count / NYEARS / 1000)) +
  geom_area(aes(fill = sex), position = "identity", alpha = 0.5) +
  geom_line(aes(group = sex)) +
  # facet_wrap(~ sex, ncol = 1) +
  labs(x = "Age", y = "Deaths per Year [thousands]") +
  scale_x_continuous(breaks = seq(0, 150, 10), limits = c(0, 120)) +
  theme_minimal() + theme(legend.title = element_blank())
#
# Stacked version.
#
ggplot(deathsage, aes(x = age, y = count / NYEARS / 1000)) +
  geom_area(aes(fill = sex), alpha = 0.5) +
  # facet_wrap(~ sex, ncol = 1) +
  labs(x = "Age", y = "Deaths per Year [thousands]") +
  scale_x_continuous(breaks = seq(0, 150, 10), limits = c(0, 120)) +
  theme_minimal() + theme(legend.title = element_blank())

ggplot(group_by(deathsage, year, age) %>% summarise(count = sum(count)), aes(x = year, y = age)) +
  geom_raster(aes(fill = count)) +
  labs(x = "Year", y = "Age") +
  theme_minimal()

ggplot(deathsage, aes(x = year, y = age)) +
  geom_raster(aes(fill = count)) +
  labs(x = "Year", y = "Age") +
  scale_y_continuous(breaks = seq(0, 120, 10), limits = c(0, 110)) +
  scale_fill_gradient("Deaths", low = "#FFFFFF") +
  facet_wrap(~ sex) +
  theme_minimal() +
  theme(panel.grid = element_blank())

plot_ly(subset(lifetable, sex == "M"), x = x, y = lx / 1000, name = "Male", line = list(color = "blue")) %>%
  add_trace(data = subset(lifetable, sex == "F"), x = x, y = lx / 1000, name = "Female", line = list(color = "red")) %>%
  layout(
    title = "Life Table",
    showlegend = T,
    xaxis = list(title = "Age", dtick = 10),
    yaxis = list(title = "Proportion Living", ticksuffix = "%")
  )

pyramid.files <- sapply(unique(deathsage$year), function(y) {
  year.data <- subset(deathsage, year == y) %>% mutate(
    count = ifelse(sex == "F", -count, count)
  )
  #
  g <- ggplot(year.data, aes(x = age, y = count, fill = sex)) +
    geom_density(data = subset(year.data, sex == "F"), stat = "identity", alpha = 0.75, col = NA) +
    geom_density(data = subset(year.data, sex == "M"), stat = "identity", alpha = 0.75, col = NA) +
    scale_y_continuous(
      limits = c(-47000, 47000),
      breaks = seq(-40000, 40000, 20000),
      labels = c(seq(40, 0, -20), seq(20, 40, 20))
    ) +
    scale_x_continuous(limits = c(0, 110), breaks = seq(0, 120, 20)) +
    coord_flip() +
    scale_fill_manual(values = c("red", "blue", "green")) +
    labs(y = "Deaths [thousands]", x = "Age") +
    ggtitle(y) +
    theme_bw() + theme(legend.title = element_blank())
  #
  filename = sprintf("pyramid-%4d.png", y)
  #
  png(filename, width = 600, height = 400)
  print(g)
  dev.off()
  #
  filename
})
#
system(paste("convert -delay 20 -loop 0", paste(pyramid.files, collapse = " "), "pyramid-animation.gif"))
#
file.remove(pyramid.files)

# BASEBALL ------------------------------------------------------------------------------------------------------------

plot_baseball_birthdates <- plot_ly(baseball, x = birthdate, type = "histogram") %>%
  layout(
    title = "Major League Baseball Birth Dates",
    xaxis = list(title = "Birth Date"),
    yaxis = list(title = "Number of Players")
  )

# plotly_POST(plot_baseball_birthdates, filename = "Exegetic Blog/baseball-birth-dates")
