username <- "996ZURIC4170"

ROOT_URL <- "http://production.shippingapis.com/ShippingAPI.dll?API=Verify&XML="
request_template <- list(
  AddressValidateRequest = list(
  )
)

validate_address <- function(usr, street, city, state){
  xml_req <- xml2::as_xml_document(request_template)
  xml2::xml_attr(xml_req, "USERID") <- username
  address_node <- xml2::xml_add_child(xml_req, "Address", ID = "0")
  
  xml2::xml_add_child(address_node, "Address1")
  xml2::xml_add_child(address_node, "Address2", street)
  xml2::xml_add_child(address_node, "City", city)
  xml2::xml_add_child(address_node, "State", state)
  xml2::xml_add_child(address_node, "Zip5")
  xml2::xml_add_child(address_node, "Zip4")
  utils::URLencode(paste0(ROOT_URL, xml_req))
}

req <- paste0(ROOT_URL, xml_req)

req2 <- sapply(req, utils::URLencode, USE.NAMES = FALSE)
executeCall <- function(req) {
  resp_list <- RCurl::getURIAsynchronous(req)
  resp_xml  <- lapply(resp_list, xml2::read_xml)
  resp      <- do.call(c, lapply(resp_xml, xml2::as_list))
  return(resp)
}
