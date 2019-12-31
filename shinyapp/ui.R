library(shinymaterial)

ui <- material_page(title = "USPS Address Validator",
  material_row(
    material_column(width = 4,
                    material_card(title = "User Inputs",depth = 5,
                                  # textInput(inputId="textInput", label = "Enter Address"),
                                  # selectizeInput(inputId = "selectizeInput", label = "Select Item", choices = c("Home", "Work")),
                                  # fileInput(inputId = "fileInput", label = NULL),
                                  # actionButton(inputId ="actionButtonInput", label = "OK"),
                                  
                                  material_text_box(input_id="mat_textInput", label = "Enter Address"),
                                  material_dropdown(input_id = "mat_dropdownInput", label = "Saved Locations", choices = c("Home"="300 N State St, Chicago, IL",
                                                                                                                           "Work"="1299 Zurich Way, Schaumburg, 60196")),
                                  material_file_input(input_id = "mat_fileInput", label = "Upload File"),
                                  material_button(input_id = "mat_buttonInput", label = "OK")
                    )
    ),
    material_column(width = 8,
                    material_card(title = "Validated Result",
                                  DT::dataTableOutput("validated_results_DT")
                    )
    )
  )
  
) 