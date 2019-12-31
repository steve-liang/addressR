library(shinymaterial)
library(dplyr)

address_list <- data_frame(Street= c("520 N. Halsted", "43 Morris", "1299 ZUrich Way",
                                     "565 W Madison", "62 North Ave", "35 Morris St North"),
                           City = c("Chicago", "chicago", "Schaumburg",
                                    "Chicago", "Chiago", "Park Ridge"),
                           State = rep("IL", 6))

username <- "996ZURIC4170"

devtools::load_all('~/addressR/R')