
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(quantmod)
library(scales)

mthlypayment <- function(p,r,n) p * (r * (1 + r) ** n) / ((1 + r) ** n - 1)
totalpayback <- function(m,n) m*n
monthsarray <- function(m) c(0:m)
pmtsched <- function(p,n,r) { 
  output <- c()
  for(m in 0:n) {
      output <- c(output,round((1+r)^m*p-((((1+r)^m)-1)/r)*mthlypayment(p,r,n),0))
  } 
  return(output) 
}
ttl <- function(p,n,r) { 
  ttlpay <- c()
  for(z in 0:n) {
    ttlpay <- c(ttlpay,z*mthlypayment(p,r,n))
  } 
  return(ttlpay) 
}

invest <- function (p,i,n,r) {

    earlypayoff <-p
    mthg <- 0
    z <- 0
    sav <- 0
    for (g in 1:n) {
      if (earlypayoff >= 0) { 
         earlypayoff <- (1+r)^g*p-((((1+r)^g)-1)/r)*(mthlypayment(p,r,n)+i)
      } else {
         sav <- (n*mthlypayment(p,r,n)) -(g * (mthlypayment(p,r,n)+i))
         mthg <- n - g 
         break
      }
    }
  return(c(sav,-mthg))
}

shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({input$loan})
    output$prediction <- renderPrint({mthlypayment(input$loan,input$rate/12/100,input$term)})
    output$payback <- renderPrint({totalpayback(mthlypayment(input$loan,input$rate/12/100,input$term),input$term)})
    output$iv <- renderPrint({invest(input$loan,input$extra,input$term,input$rate/12/100)})
    #output$fastpay <- renderPrint({invest(input$loan,input$extra,input$term,input$rate/100)})
    output$plot <- renderPlot({
    values <- reactiveValues(df_data = NULL)
      values$df_data <- data.frame(x=monthsarray(input$term), y1 = pmtsched(input$loan,input$term,input$rate/12/100), 
                        y2=ttl(input$loan,input$term,input$rate/12/100))
        observeEvent(input$Submit, {
         temp <- values$df_data[-input$Delete, ]
         values$df_data <- temp
         values$df_data <- data.frame(x=monthsarray(input$term), y = pmtsched(input$loan,input$term,input$rate/12/100),
                        y2=ttl(input$loan,input$term,input$rate/12/100))
        })
      p <- ggplot(values$df_data, aes(x)) + geom_line(aes(y=y1,colour="Principal"),size=1)
      p <- p + geom_line(aes(y=y2,colour="Total Payment"),size=1) 
      p <- p + xlab("Loan Term in Months") 
      p <- p + ggtitle("Plotting Amortization Schedule and Total $ Paid")
      p <- p + scale_colour_manual("", 
                          breaks = c("Principal", "Total Payment"),
                          values = c("red", "green"))
      p <- p + scale_y_continuous("US Dollars $", labels = comma)
      p
    })

  }
)

