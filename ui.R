# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(wordcloud)
library(RColorBrewer)

# Define UI for application that draws a histogram

shinyUI(fluidPage(
  
  # Application title
  
  titlePanel("Next Word Predictor"),
  
  # Sidebar with a slider input for number of bins 
  
  sidebarLayout(
    
    sidebarPanel(
  
      h4("Please let me have your thoughts ...."),
      textAreaInput("text", "Type or Copy & Paste below:", width="100%", rows=4),
      br(),
      sliderInput("numPrediction", "Number of words to predict (3 to 20):", 
                  min=3, max=20, value=5),
      HTML('<p align="center"><img src="logo.png"/></p>')
      ),
    
    # Show a plot of the generated distribution
    
    mainPanel(
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Predictions", 
                           h4("Are you thinking of one of these words next?"),
                           p("Click on the word to add it to the sentence."),      
                           
                           htmlOutput("prediction"),
                           hr(),
                           h4("Gazing at the crystal ball ..."),
                           br(),
                           div(style = "padding: 0px 0px; margin-top:-2em", align="center", 
                               plotOutput("wordcloud", width="300px",height="300px")
                           )
                           
                  ),
                  tabPanel("About",  
                           h3("Introduction"),
                           p("This app is the final project assignment for the John Hopkins Data Science Specialization Capstone. The project was done in partnership with SwiftKey, a software company specializing in predictive keyboard applications."),
                           h3("How to use"),
                           p("Type a phrase in the box and let Next Word Predictor list possible next words. Click on the suggested word you like to use and it will be added to your sentence."),
                           h3("How it works"),
                           p("The predictive model is created by extracting text lines from twitter, news, and blogs. The corpuses are first cleansed i.e. converted to lowercase and numbers, special characters, hastags and urls removed."),
                           p("NGrams of size 2 to 5 are created."),
                           p("The logic follows the Stupid backoff model starting with a search on the highest Ngram, backing off to the lower Ngrams. The score is multiplied by a factor of 0.4  for each level backed down."),
                           p("Discount/smoothing is not applied in the model to speed up computation of the predicted words."),
                           h3("Links"),
                           p(HTML("The code files for Next Word Predictor can be found on <a href='https://github.com/chengseng/DataScienceCapstone'  target='_blank'>GitHub</a>.")),
                           p(HTML("The pitch presentation for the app can be found on <a href='http://rpubs.com/ChengSeng/417465' target='_blank'>RPubs</a>")),     
                           p(HTML("The dataset source for the text files used was taken from <a href='https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip'  target='_blank'>Coursera-SwiftKey</a>.")),
                           
                           br()
                  )
      )
      
    )
    
  ),
  
  includeHTML("./addword.HTML")
  
))