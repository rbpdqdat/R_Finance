
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

# Define UI for dataset viewer application
shinyUI(


  pageWithSidebar(
    # Application title
    headerPanel("Loan Terms"),
    
    sidebarPanel(
      numericInput('term', 'Loan term in months', 120, min = 48, max =1200, step=6),
      numericInput('rate', 'Interest Rate %', 3.5, min =2.0, max = 25, step = 1/8),
      numericInput('loan', 'Loan Amount in $', 50000, min = 5000, max = 999999, step = 1000),
      numericInput('extra', 'Extra Monthly $', 0, min = 0, max = 2000, step = 100),
      submitButton('Submit')
    ),
    mainPanel(
      h4("Link to User Documentation:"),
      a("https://github.com/rbpdqdat/R_Finance/new/master?readme=1"),
      p(""),
      h3('Looking at Loan Payoff Information'),
      h4('Your Initial Loan Amount'),
      verbatimTextOutput("inputValue"),
      h4('Which results in a monthly payment of '),
      verbatimTextOutput("prediction"),
      h4('Which results in a total payback of '),
      verbatimTextOutput("payback"),
      h4('Paying extra amount monthly Results in ~ savings (1) and early payoff (2-months):'),
      verbatimTextOutput("iv"),
      plotOutput("plot")
    )
  )
)