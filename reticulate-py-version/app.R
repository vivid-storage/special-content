library(shiny)
library(reticulate)

ui <- fluidPage(
  titlePanel("Display the Python Version through reticulate"),
  verbatimTextOutput("python_version")
)

server <- function(input, output, session) {
  output$python_version <- renderPrint({
    python_version <- as.character(py_config()$version)
    cat("Python version:", python_version, "\n")
  })
}

shinyApp(ui, server)
