#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)



library(markdown)

shinyUI(fluidPage(
    
    titlePanel("Choose a car that suits your needs"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Its important to choose  a car that is important. and it should make your life easier not harder. it is important to make a well informed decision and for that we need to compare our existing options."),
            numericInput('thisisdistance', 'Distance (in miles):', 50, min = 1, max = 1000),
            numericInput('candthisiscost', 'Gasoline Price (per gallon):', 2.41, min = 2, max = 4, step=0.01),
            numericInput('whatsthegas', 'Maximum expenditure on gasoline:', 50, min=1, max=1000),
            checkboxGroupInput('letscheckcyl', 'Number of cylinders:', c("Four"=4, "Six"=6, "Eight"=8), selected = c(4,6,8)),
            sliderInput('alsothedisp', 'Displacement', min=70, max=480, value=c(70,480), step=10),
            sliderInput('letsnotforgetthehp', 'Gross horsepower', min=50, max=340, value=c(50,340), step=10),
            checkboxGroupInput('lastlyisitautomatic', 'Transmission:', c("Automatic"=0, "Manual"=1), selected = c(0,1))
        ),
        mainPanel(
            dataTableOutput('table')
        )
    )
    
)
)   
