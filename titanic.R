#Set working directory
setwd("C:/Users/erin/Dropbox/Springboard")
library(tidyr)
library(dplyr)

# Read in data
df <- read.csv("titanic_original.csv")
df <- rename(df, pclass = ï..pclass)

# Replace missing values in embarked with "S"
df$embarked[df$embarked == ""] <- "S"

#Replace missing age with mean age
df$age[is.na(df$age)] <- mean(df$age, na.rm = TRUE)

# Replace missing lifeboats
df$boat <- as.character(df$boat)
df$boat[df$boat == ""] <- "None"

# Crete variable for missing cabins
df$cabin <- as.character(df$cabin)
has_cabin_number <- as.numeric(df$cabin != "")
df <- cbind(df, has_cabin_number)

# Output file
write.csv(df, file = "titanic_clean.csv")