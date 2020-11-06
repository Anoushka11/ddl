#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
library(dplyr)

shinyServer(function(input, output) {
    
    ot <- renderDataTable({
        disseq <- seq(from = input$disp[1], to = input$disp[2], by = 0.1)
        hpseq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
        otdt <- transmute(mtcars, Car = rownames(mtcars), MilesPerGallon = mpg, 
                          GasolineExpenditure = input$dis/mpg*input$cost,
                          Cylinders = cyl, Displacement = disp, Horsepower = hp, 
                          Transmission = am)
        otdt <- filter(otdt, GasolineExpenditure <= input$gas, Cylinders %in% input$cyl, 
                       Displacement %in% diseq, Horsepower %in% hpseq, Transmission %in% input$am)
        otdt <- mutate(otdt, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
        otdt <- arrange(otdt, GasolineExpenditure)
        otdt
    }, options = list(lengthMenu = c(5, 15, 30), pageLength = 30))
    
})