#Set working directory
setwd("C:/Users/erin/Dropbox/Springboard")
library(tidyr)
library(dplyr)

#Read in data
data <- read.csv("refine_original.csv")

# Step 1 - Clean up brand names
data <- rename(data, company = ï..company)
data$company = tolower(data$company)
data$company <- sub("ak zo", "akzo", data$company)
data$company <- sub("akz0", "akzo", data$company)

for (x in c("fillips", "philips","phillps","phlips","phllips")) {
  data$company <- sub(x, "phillips", data$company)
}

data$company <- sub("unilver", "unilever", data$company)


# Split product code
data <- rename(data, product = Product.code...number)
data <- separate(data, "product", c("product_code","product_number"), "-", remove = FALSE)

# Assign product categories
product_code <- c("p","q","v","x")
product_category <- c("Smartphone","TV","Laptop","Tablet")
prod_cat <- data.frame(product_code, product_category)
data <- left_join(data,prod_cat)

# Create full address
data <- unite(data, full_address, address, city, country, sep = ",", remove = FALSE)

# Create dummy variables for company and product category - can this be done in a loop?
company_phillips <- as.numeric(data$company == "phillips")
company_azko <- as.numeric(data$company == "azko")
company_van_houten <- as.numeric(data$company == "van houten")
company_unilever <- as.numeric(data$company == "unilever")
product_smartphone <- as.numeric(data$product_category == "Smartphone")
product_tv <- as.numeric(data$product_category == "TV")
product_laptop <- as.numeric(data$product_category == "Laptop")
product_tablet <- as.numeric(data$product_category == "Tablet")
data <- cbind(data, company_phillips, company_azko, company_unilever, company_van_houten, product_smartphone, product_laptop, product_tablet, product_tv)

# Output file
write.csv(data, file = "refine_clean.csv")