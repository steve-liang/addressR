library(shinymaterial)

ui <- material_page(
  material_row(
    material_column(width = 4,
                    material_card(title = "filter",depth = 5,
                                  textInput(inputId="textInput", label = "Enter Address"),
                                  material_text_box(input_id="mat_textInput", label = "Enter Something"),
                                  selectizeInput(inputId = "selectizeInput", label = "Select Item", choices = c("Home", "Work")),
                                  material_dropdown(input_id = "mat_dropdownInput", label = "Select Item", choices = c("Home", "Work")),
                                  fileInput(inputId = "fileInput", label = NULL),
                                  material_file_input(input_id = "mat_fileInput", label = "Upload File"),
                                  actionButton(inputId ="actionButtonInput", label = "OK")
                    )
    ),
    material_column(width = 8,
                    material_card(title = "Validated Result",
                                  DT::dataTableOutput("validated_results_DT")
                                  )
    )
  )
  
) 