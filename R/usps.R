
ROOT_URL <- "http://production.shippingapis.com/ShippingAPI.dll?API=Verify&XML="

request_template <- list(
  AddressValidateRequest = list(
  )
)

#' Recompose address to follow USPS API specs
#'
#' @param usr
#' @param street
#' @param city
#' @param state
#' @param zip
#'
#' @return
#' @export
#'
#' @examples
#' compose_xml(USPS_USER_KEY, "123 Main Street", "Chicago", "IL", "60421")
compose_xml <- function(usr, street, city, state, zip = NULL){
  xml_req <- xml2::as_xml_document(request_template)
  xml2::xml_attr(xml_req, "USERID") <- usr
  address_node <- xml2::xml_add_child(xml_req, "Address", ID = 0)
  xml2::xml_add_child(address_node, "Address1")
  xml2::xml_add_child(address_node, "Address2", street)
  xml2::xml_add_child(address_node, "City", city)
  xml2::xml_add_child(address_node, "State", state)
  xml2::xml_add_child(address_node, "Zip5", zip)
  xml2::xml_add_child(address_node, "Zip4")
  utils::URLencode(paste0(ROOT_URL, xml_req))
}

#' Execute API call(s) to USPS
#'
#' @param req API request recomposed from calling \code{compose_xml}
#'
#' @return data frame with cols: Street, City, State, Zip, Zip4
#' @export
executeCall <- function(req) {
  resp_list <- RCurl::getURIAsynchronous(req)
  resp_xml  <- lapply(resp_list, xml2::read_xml)
  resp      <- do.call(c, lapply(resp_xml, xml2::as_list))
  if(is.null(resp$AddressValidateResponse$Address$Error)){
    res <- dplyr::data_frame(Street = resp$AddressValidateResponse$Address$Address2[[1]],
                             City = resp$AddressValidateResponse$Address$City[[1]],
                             State = resp$AddressValidateResponse$Address$State[[1]],
                             Zip =  resp$AddressValidateResponse$Address$Zip5[[1]],
                             Zip4 =  resp$AddressValidateResponse$Address$Zip4[[1]]
    )

    return(res)
  }
}

######### TODO #########
#
# validate_address <- function(usr, address_df){
#   dplyr::mutate(address_df, xml_url = ifelse(!is.na(Street), compose_xml(usr, Street, City, State, row_number())))
# }
#
# batch_compose_xml <- function(usr, street, city, state, row_index){
#   xml_req <- xml2::as_xml_document(request_template)
#   xml2::xml_attr(xml_req, "USERID") <- usr
#
#   address_node <- xml2::xml_add_child(xml_req, "Address", ID = row_index %% 5)
#   xml2::xml_add_child(address_node, "Address1")
#   xml2::xml_add_child(address_node, "Address2", street)
#   xml2::xml_add_child(address_node, "City", city)
#   xml2::xml_add_child(address_node, "State", state)
#   xml2::xml_add_child(address_node, "Zip5")
#   xml2::xml_add_child(address_node, "Zip4")
#   xml_req
#   #  utils::URLencode(paste0(ROOT_URL, xml_req))
# }
#
# req2 <- sapply(req, utils::URLencode, USE.NAMES = FALSE)
