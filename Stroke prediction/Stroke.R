setwd("/Users/seominji/Desktop/Unstruct_DA")
stroke_data<- read.csv("healthcare-dataset-stroke-data.csv")
head(data)
str(data)
summary(data)
# check unique values of categorical values
cat("Gender:")
unique(stroke_data$gender)
cat("Married:");unique(stroke_data$ever_married)
cat("Work type:");unique(stroke_data$work_type)
cat("Residence type:");unique(stroke_data$Residence_type)
cat("Smoking:");unique(stroke_data$smoking_status)


# load libraries
library(tidyverse) # metapackage of all tidyverse packages
install.packages("naniar")
library(naniar) # handling missing data
install.packages("skimr")
library(skimr) # quick overview over the dataset
install.packages("caret")
library(caret) # ML toolkit
install.packages("MLmetrics")
library(MLmetrics) # F1 Score
install.packages("imbalance")
library(imbalance) # algorithms to deal with imbalanced datasets
install.packages("gridExtra")
library(gridExtra) # display plots in grids
install.packages("patchwork")
library(patchwork) # arrange plots side by side

miss_scan_count(data = stroke_data, search = list("N/A", "Unknown"))
miss_var_summary(data = stroke_data, search = list("N/A", "Unknown"))
gg_miss_var(stroke_data)

fig(15, 8)

stroke_data %>%
  group_by(smoking_status) %>%
  summarise(count = length(smoking_status)) %>%
  mutate(smoking_status = factor(smoking_status)) %>%
  ggplot(aes(x = fct_reorder(smoking_status, count), y = count, fill = factor(ifelse(smoking_status=="Unknown","Unknown","Known")))) +
  geom_col() +
  geom_text(aes(label = count, x = smoking_status, y = count), size = 6, hjust = 1.5) +
  coord_flip() +
  scale_fill_manual(values = c("Unknown" = "red", "Known" = "darkgrey")) +
  labs(x = "smoking status") +
  theme(legend.position = "none") +
  theme_bigfont

######분석중