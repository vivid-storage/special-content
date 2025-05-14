library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "Installed Packages",
  sidebar = sidebar(
    h4("Package Information"),
    p("This app displays all currently installed R packages and their version numbers.")
  ),
  card(
    card_header("Installed R Packages"),
    card_body(
      uiOutput("packageInfo")
    )
  )
)

server <- function(input, output, session) {
  # Generate the package information as HTML elements
  output$packageInfo <- renderUI({
    # Get installed packages info
    pkgs <- installed.packages()
    # Create a data frame with package names and versions
    pkg_info <- data.frame(
      Package = pkgs[, "Package"],
      Version = pkgs[, "Version"],
      stringsAsFactors = FALSE
    )
    # Sort by package name
    pkg_info <- pkg_info[order(pkg_info$Package), ]
    
    # Create a list of HTML elements for each package
    package_elements <- lapply(1:nrow(pkg_info), function(i) {
      pkg_name <- pkg_info$Package[i]
      pkg_version <- pkg_info$Version[i]
      
      # Create a single span with id attribute and text that includes both package name and version
      # This ensures Playwright can locate by text using both package name and version
      div(
        class = "package-item",
        span(
          id = paste0("pkg-", pkg_name),
          paste0(pkg_name, ": ", pkg_version)
        )
      )
    })
    
    # Wrap all package elements in a div with some styling
    div(
      id = "packages-container",
      style = "font-family: monospace; line-height: 1.5;",
      package_elements
    )
  })
}

shinyApp(ui, server)
