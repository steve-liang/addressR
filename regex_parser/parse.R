
to_building_address <- function(x, removeStreetName = TRUE){
  #### STEP 1, Suite/Unit Number #######
  x <- stringr::str_replace_all(x, "#[[:digit:]]*", "")
  x <- stringr::str_replace_all(x, "SUITE [[:digit:]]*", "")
  
  #### STEP 2: Remove Punctuations but keep hypthon between numbers in case of range of street numbers
  x <- stringr::str_replace_all(x, "[[:punct:]&&[^-]]|(?<![[:digit:]])-|-(?![[:digit:]])", "")
  
  #### STEP 3: Standardize Numbered Street Name, Directions, Suffix
  x <- stringr::str_replace_all(x, stringr::regex(suffix_mapping, ignore_case = TRUE))
  x <- stringr::str_replace_all(x, stringr::regex(dir_mapping, ignore_case = TRUE))
  # x <- stringr::str_replace_all(x, stringr::regex(nsn_mapping, ignore_case = TRUE))
  
  ### FINAL STEP: remove extra spaces
  x <- stringr::str_squish(stringr::str_to_upper(x))
  return(x)
}

