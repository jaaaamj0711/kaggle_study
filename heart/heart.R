setwd("/Users/seominji/Desktop/Unstruct_DA")

## load library ##
library(tidyverse)
library(ggcorrplot)
library(lattice)
library(psych)
library(DataExplorer)
library(reshape2)
library(car)
library(caret)
library(data.table)
library(e1071) 
library(scales)
library(stringr)
library(gridGraphics)
library(gridExtra)
library(cowplot)
library(lmtest)
library(gvlma)
library(RColorBrewer)
library(packHV)
library(caTools)

# data load #
data<-read.csv("framingham.csv")
head(data)
str(data)

colSums(is.na(data))
data$TenYearCHD<- as.factor(data$TenYearCHD)
data<- data %>% mutate(HD = TenYearCHD)

data$TenYearCHD<- factor(data$TenYearCHD, labels = c('No',"Yes"))

data<- data %>% rename("Heart Disease" = TenYearCHD,
                       Gender = male,
                       Age = age,
                       Education = education,
                       Smoker = currentSmoker)

data$Gender<- factor(data$Gender, labels = c("Female","male"))

# na값을 다른 값으로 대체
data$Education<- data$Education %>% replace_na(5)
data$Education<- factor(data$Education,
                        labels = c("Some High School",
                                   "High School or GED",
                                   "Some College/Vocational School",
                                   "College", "Other"))

data$Smoker<- factor(data$Smoker, labels = c("Smoker","Non-Smoker"))
data$BPMeds <- data$BPMeds %>% replace_na(0)
data$BPMeds = factor(data$BPMeds, labels = c("No Medication", "Medication"))
data$prevalentStroke = factor(data$prevalentStroke,
                            labels = c("No", "Yes"))

data$prevalentHyp = factor(data$prevalentHyp, 
                         labels = c("No", "Yes"))
data$diabetes = factor(data$diabetes, labels = c("No", "Yes"))
hist(data$Age, col = "grey40")
b = seq(min(data$Age)-2, max(data$Age)+8, 10);
data$A <- cut(data$Age, breaks = b, right = T)
table(data$A)

data <- data %>% select(HD,`Heart Disease`, A, Gender, Education, Smoker, 
                    BPMeds, prevalentStroke, everything())


data$glucose = replace_na(data$glucose, median(data$glucose, na.rm = T))

data = drop_na(data)
sum(is.na(data))

# ----  Heart Disease counts
a = ggplot(data, aes(`Heart Disease`, fill = `Heart Disease`, color = `Heart Disease`)) + 
  geom_bar(stat = "count", lwd = 2) + scale_fill_manual(values=c("#C7E9B4", "#225EA8")) + 
  scale_color_manual(values=c('seagreen4', "#253494")) + 
  labs(title = "Heart Disease") +  theme_bw(base_size = 18) +
  theme(legend.position="bottom")

# ----  Gender   ------






#################################################################
#---------------------------------------------------------------#
#######   Visualize the Data Distributions/Interactions    ######
#---------------------------------------------------------------#
#################################################################

# ----- Age & Heart Disease  -------
a = ggplot(df,aes(Age, fill = `Heart Disease`, color = `Heart Disease`)) + 
  geom_density(lwd = 3, show.legend = T, alpha = 0.7) + 
  labs(title = "Age & Hypertension") + facet_grid(~prevalentHyp) +
  scale_fill_manual(values=c("#C7E9B4", "#1D91C0")) + 
  scale_color_manual(values=c('seagreen4', "#253494")) +
  theme_bw(base_size = 18) + theme(legend.position="bottom") +
  theme(strip.background = element_rect(fill="snow1")) +
  theme(strip.text = element_text(face = "bold", size = 18)) +
  geom_vline(xintercept = mean(df$Age), lwd = 2.5, 
             color = "#081D58", linetype = 4)

# ----- Systolic Blood Pressure & Hypertension  -------
b = ggplot(df,aes(sysBP, fill = `Heart Disease`, color = `Heart Disease`)) + 
  geom_density(lwd = 3, show.legend = T, alpha = 0.7) + 
  labs(title = "Systolic Blood Pressure & Hypertension") + facet_grid(~prevalentHyp) + 
  scale_fill_manual(values=c("#C7E9B4", "#1D91C0")) + 
  scale_color_manual(values=c('seagreen4', "#253494")) +
  theme_bw(base_size = 18) + theme(legend.position="bottom")+
  theme(strip.background = element_rect(fill="snow1")) +
  theme(strip.text = element_text(face = "bold", size = 18)) +
  geom_vline(xintercept = mean(df$sysBP), lwd = 2.5, 
             color = "#081D58", linetype = 4)

options(repr.plot.width=16, repr.plot.height=7)
plot_grid(a,b, ncol = 2, nrow = 1)
