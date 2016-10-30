
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
      h4("User Documentation:"),
      p("The following application will take User 'Loan Term' information:"),
      p(" 'Loan term in months' = Length of loan"),
      p(" 'Interest Rate' = The annual rate of interest on the borrowed money"),
      p(" 'Loan Amount in $' = The principal/original loan amount"),
      p(" 'Extral Monthly $' = Any additional money paid each month"),
      p(""),
      p("And return Inital Loan Amount, Monthly Payment, Total Payback, and also the number of months and dollars saved if paying additional $ each month."),
      p("The graph indicates the reduction in principal owed (red), while the green shows the total amount paid through time referring to the payment schedule without addtional monthly $ added to the payment."),
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