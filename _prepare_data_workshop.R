
# Download Singapore data

# Load necessary libraries
library(dplyr)
library(data.table)

# Load function to filter data
source("functions.R")

# Download the data
download_wpp24(include_projections = T)

# Get data

fert_female <-
  UNWPP_data(country = "Singapore", 
             start_year = 1950, 
             end_year = 2100,
             sex = c("Female"),
             indicators = c("fx"), #indicators of interest
             output_format = "csv", #format you want to save (csv or rdata)
             output_file = "Singapore") 

mort_both <-
  UNWPP_data(country = "Singapore", 
             start_year = 1950, 
             end_year = 2100,
             sex = c("Male", "Female"),
             indicators = c("px"), #indicators of interest
             output_format = "csv", #format you want to save (csv or rdata)
             output_file = "Singapore") 

pop_female <-
  UNWPP_pop(country = "Singapore", 
            start_year = 1950, 
            end_year = 2100, 
            sex = "Female")

pop_male <-
  UNWPP_pop(country = "Singapore", 
            start_year = 1950, 
            end_year = 2100, 
            sex = "Male")

# Reshape

rates_female <- 
  mort_both %>% 
  filter(Sex == "Female") %>% 
  left_join(fert_female, by = c("year", "age", "Sex")) %>% 
  select(-Sex)

rates_male <- 
  mort_both %>% 
  filter(Sex == "Male") %>% 
  select(-Sex)

# Export ----

write.csv(rates_female, "data/sgp_female.csv", row.names = F)
write.csv(rates_male, "data/sgp_male.csv", row.names = F)
write.csv(pop_female, "data/sgp_popfemale.csv", row.names = F)
write.csv(pop_male, "data/sgp_popmale.csv", row.names = F)
