
library(dplyr)
library(fuzzyjoin)
recompose_address <- function(addr_string){
  recompose.fun <- function(x){
    l <- sort(unlist(stringr::str_split(x, " ")))
    paste(l, collapse = " ")
  }
  unlist(purrr::map(addr_string, recompose.fun))
}

account_loc <- data.frame(account_address = c("1100 S KIMBALL AVE",
                                      "1105 S. KIMBAL AVE",
                                      "1105 South Kimball Avenue",
                                      "1100 S KIMBALL Avenue, #312"))

loss_loc <- data.frame(loss_address = c("123 Ave", 
                                   "1100 S kimball ave",
                                   "1105 kimbal ave s",
                                   "1105 kimball",
                                   "NULL",
                                   "312 N Halsted"),
                       loss_amount = c(123,223,40,12, 0, 312))

loss_loc <- loss_loc %>% mutate(ADDRESS=recompose_address(loss_address))

account_loc <- account_loc %>% mutate(ADDRESS=recompose_address(account_address))

stringdist_inner_join(loss_loc, account_loc, 
                      by = c("ADDRESS"="ADDRESS"),
                      max_dist = 5, 
                      ignore_case = TRUE, 
                      distance_col = "difference") %>% 
  group_by(loss_address) %>% 
  filter(difference==min(difference)) %>% 
  ungroup()
