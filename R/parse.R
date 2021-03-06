
#' Regex standardization to convert unit level address to building level
#'
#' @param x the raw address as the input
#' @param removeSuffix if TRUE(default), remove the street suffix like St, Ave, Blvd, etc
#'
#' @return cleansed address at building level
#' @export
#'
#' @examples
#' to_building_address("123 Main Street, Unit #1", removeSuffix=TRUE)
to_building_address <- function(x, removeSuffix = TRUE){
  #### STEP 1, Suite/Unit Number #######
  #### thanks to https://stackoverflow.com/questions/51370415/remove-unit-number-clause-from-street-address-string-in-r
  # x <- stringr::str_replace_all(x, "#[[:digit:]]*", "")
  x <- stringr::str_replace_all(x, "(?i)(SUITE|STE|UNIT|APT)s? \\S+", "")
  x <- stringr::str_replace_all(x, "#\\S+", "")

  #### STEP 2: Remove Punctuations but keep hypthon between numbers in case of range of street numbers
  x <- stringr::str_replace_all(x, "[[:punct:]&&[^-]]|(?<![[:digit:]])-|-(?![[:digit:]])", "")

  #### STEP 3: Standardize Numbered Street Name, Directions, Suffix
  x <- stringr::str_replace_all(x, stringr::regex(suffix_mapping, ignore_case = TRUE)) # standardize street suffix
  x <- stringr::str_replace_all(x, stringr::regex(dir_mapping, ignore_case = TRUE)) # standardize directions
  x <- stringr::str_replace_all(x, stringr::regex(nsn_mapping, ignore_case = TRUE)) # standardize numbered street name

  if(removeSuffix){
    x <- stringr::str_replace_all(x, stringr::regex(paste0("\\b",
                                                           paste(collapse = "\\b|\\b", unname(suffix_mapping)),
                                                           "\\b"), ignore_case = TRUE), "")
  }

  ### FINAL STEP: convert to upper case and remove extra spaces
  x <- stringr::str_squish(stringr::str_to_upper(x))

  return(x)
}

