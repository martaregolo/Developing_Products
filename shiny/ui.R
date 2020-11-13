library(shiny)
library(plotly)
library(shinyWidgets)
fluidPage(
    br(),
    fluidRow(
        column(width=5, wellPanel(
            fluidRow(selectInput("regressor","Regressor",names(longley)[1:6])),
            fluidRow(sliderInput("regrpred","What is your value ?",min=100,max=300,value=25)),
        ))),
    br(),br(),
    fluidRow(
    column(width=8,offset=2,
        panel(
        plotlyOutput("plot1"),
        h3("Predicted number of people employed:"),
        textOutput("pred1")
        )
    ))
)