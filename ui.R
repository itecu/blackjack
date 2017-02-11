#
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
  shinyjs::useShinyjs(),
  titlePanel("Blackjack"),
  h3("Dealers cards"),
  fluidRow(
    column(11,
           uiOutput("dealer"),
           br(),
           br(),
           h3("Your cards"),
           uiOutput("player"),
           br(),
           br()
  )),
  fluidRow(
    column(2),
    column(8,
           verbatimTextOutput("text")
    ),
    column(2)
  ),
  fluidRow(
      column(4),
      column(4,
             h3("Game Options")
      ),
      column(4)
    ),
  fluidRow(
      column(2),
      column(6,
             p("Press Hit to draw a card, Stand to stand and Start to start a new game"))
      
    ),
   fluidRow( 
      column(1),
      column(3,
             actionButton("hit", label = "Hit",icon("step-forward", lib = "glyphicon"), 
                          style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
      ),
     column(1),
      column(3,
             actionButton("stand", label = "Stand",icon("stop", lib = "glyphicon"), 
                          style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
      ),
     column(1),
      column(3,
             actionButton("start",label = "Start",icon("play", lib = "glyphicon"), 
                          style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
      )
      
  ),
  fluidRow(
    column(4),
    column(4,
           h3("Rules")
    ),
    column(4)
  ),
  fluidRow(
    column(1),
    column(10,
           strong("Cards"),
           p("The standard 52-card pack is used"),
           strong("Objective"),
           p("The player attempts to beat the dealer by getting a count as close to 21 as possible, without going over 21"),
           strong("Scoring"),  
           p("It is up to each individual player if an Ace is worth 1 or 11. Face cards are 10 and any other card is its pip value") ,
           strong("Order of play"),  
           p("The player will draw cards first and then the dealer")
    )
  )
)
)

