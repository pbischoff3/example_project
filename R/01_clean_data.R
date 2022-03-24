# this script cleans the penguin data 

library(tidyverse)
library(palmerpenguins)
library(janitor)

penguins_raw %>% 
  glimpse

df <- penguins_raw %>% 
  janitor::clean_names()

df %>% glimpse

df <- df %>% 
  select(species,island,date_egg,culmen_length_mm,culmen_depth_mm,flipper_length_mm,body_mass_g,sex)

df %>% glimpse
df$species %>% unique %>% 
  str_split(" ") %>% 
  map_chr(1)

clean <- df %>% 
  mutate(species = species %>%
           str_split(" ") %>% 
           map_chr(1), 
         year = date_egg %>% 
           str_split("-") %>% 
           map_chr(1) %>% 
           as.numeric()) %>% 
    select(-date_egg) %>% 
      rename(bill_length_mm = culmen_length_mm,
             bill_depth_mm = culmen_depth_mm)

write_csv(clean,"./Data/Clean/clean_penguins_data2.csv")

read_csv("./Data/Clean/clean_penguins_data.csv")
