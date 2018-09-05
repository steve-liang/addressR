account_loc <- data.frame(address = c("1100 S KIMBALL AVE",
                                      "1105 S. KIMBAL AVE",
                                      "1105 South Kimball Avenue",
                                      "1100 S KIMBALL Avenue, #312"))

loss_loc <- data.frame(address = c("123 Ave", 
                                   "1100 S kimball ave",
                                   "1105 kimbal ave s",
                                   "1105 kimball",
                                   "NULL",
                                   "312 N Halsted"),
                       amount = c(123,223,40,12, 0, 312))


recompose_address <- function(addr_string){
  recompose.fun <- function(x){
    l <- sort(unlist(stringr::str_split(x, " ")))
    paste(l, collapse = " ")
  }
  purrr::map_df(addr_string, .f = function(x){dplyr::data_frame(address=recompose.fun(x))})
}


library(dplyr)
library(fuzzyjoin)
addr_list_recomposed <- addr_list %>% mutate(ADDRESS=recompose_address(Address))

stringdist_inner_join(loss_loc, account_loc, 
                      max_dist = 5, 
                      ignore_case = TRUE, 
                      distance_col = "difference") %>% 
  group_by(address.x) %>% 
  filter(difference==min(difference)) %>% 
  ungroup()
