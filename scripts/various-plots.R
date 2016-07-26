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

plot_ly(subset(lifetable, sex == "M"), x = age, y = lx / 1000, name = "Male", line = list(color = "blue")) %>%
  add_trace(data = subset(lifetable, sex == "F"), x = age, y = lx / 1000, name = "Female", line = list(color = "red")) %>%
  layout(
    title = "Life Table",
    showlegend = T,
    xaxis = list(title = "Age", dtick = 10),
    yaxis = list(title = "Proportion Living", ticksuffix = "%")
  )