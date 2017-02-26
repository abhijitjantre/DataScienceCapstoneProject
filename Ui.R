library(shiny)
shinyUI(fluidPage(
        
        titlePanel(title = h6(tags$b("Predicting The Next Word"), align = "center",style = "font-family: 'Lobster', cursive;font-size: 40px;
        font-weight: 1000; line-height: 2.1; 
                              color: #4d3a7d;")),
        sidebarLayout(
                sidebarPanel(
                        textInput("rinput","Please Enter Your Text/Phrase/Words"),
                        helpText("Please enter your text/phrase/word(s) and then click on the Submit For Prediction"),
                        submitButton("Submit For Prediction"),
                        tags$style(".well {background-color:#dec4de;}")
                        
                ),
                mainPanel(
                        h4(a("Cleaned Text")),
                        textOutput("cleaned"),
                        br(),
                        h4(a("First Best Prediction")),
                        textOutput("firstbestguess"),
                        br(),
                        h4(a("Second Best Prediction")),
                        textOutput("secondbestguess")
                )
        )
))