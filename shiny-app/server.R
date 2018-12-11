server <- function(input, output){
  
  validated_res <- reactive({
    req(input$mat_textInput)
    
    entered_addr <- input$mat_textInput
    
    street <- trimws(stringr::str_split(entered_addr, pattern = ",")[[1]][1])
    city <- trimws(stringr::str_split(entered_addr, pattern = ",")[[1]][2])
    state <- trimws(stringr::str_split(entered_addr, pattern = ",")[[1]][3])
    
    xml_req <- compose_xml(username, street, city, state)
    executeCall(xml_req)
  })
  
  output$validated_results_DT <- DT::renderDataTable({
    validate(need(nrow(validated_res()) > 0, message = "Cannot find validated address, try again"))
    DT::datatable(validated_res())
  })
  
}