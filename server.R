#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
L=list()
color=c("spades","clubs","hearts","diamonds")
nb=c("02","03","04","05","06","07","08","09","10","Jack","Queen","King","Ace")
scr=c(2,3,4,5,6,7,8,9,10,10,10,10,1)
shuffle<-sample(52)
N=1:52
for(n in N){
  i=trunc((n-1)/4)+1  #number
  j=(n-1)%%4+1        #color
  name_card=paste("1000px_",nb[i],"_of_",color[j],'.png',sep="")
  L[[n]]=name_card
}
divstart='div(style="display:inline-block",'
playerfirstcard=paste('img(src = "Cards/',L[[shuffle[1]]],'",width=100,height=150),',sep="")
playerlastcard=paste('img(src = "Cards/',L[[shuffle[2]]],'",width=100,height=150)',sep="")
dealerfirstcard=paste('img(src = "Cards/',L[[shuffle[3]]],'",width=100,height=150),',sep="")
dealerlastcard=paste('img(src = "Cards/',L[[shuffle[4]]],'",width=100,height=150)',sep="")
poz=4
playercards=paste(divstart,playerfirstcard,playerlastcard)
dealercards=paste(divstart,dealerfirstcard,dealerlastcard)
dealerscore=c(0)
playerscore=c(0)
dealercount=1
playercount=1
if (scr[trunc((shuffle[3]-1)/4)+1] > 1) {dealerscore[1:dealercount]<-dealerscore[1:dealercount]+scr[trunc((shuffle[3]-1)/4)+1]
   } else { dealerscore[1:dealercount]<-dealerscore[1:dealercount]+1
            dealerscore[(dealercount+1):(2*dealercount)]<-dealerscore[1:dealercount]+10
            dealercount<-2*dealercount}
if (scr[trunc((shuffle[4]-1)/4)+1] > 1) {dealerscore[1:dealercount]<-dealerscore[1:dealercount]+scr[trunc((shuffle[4]-1)/4)+1]
} else { dealerscore[1:dealercount]<-dealerscore[1:dealercount]+1
dealerscore[(dealercount+1):(2*dealercount)]<-dealerscore[1:dealercount]+10
dealercount<-2*dealercount}
if (scr[trunc((shuffle[1]-1)/4)+1] > 1) {playerscore[1:playercount]<-playerscore[1:playercount]+scr[trunc((shuffle[1]-1)/4)+1]
} else { playerscore[1:playercount]<-playerscore[1:playercount]+1
playerscore[(playercount+1):(2*playercount)]<-playerscore[1:playercount]+10
playercount<-2*playercount}
if (scr[trunc((shuffle[2]-1)/4)+1] > 1) {playerscore[1:playercount]<-playerscore[1:playercount]+scr[trunc((shuffle[2]-1)/4)+1]
} else { playerscore[1:playercount]<-playerscore[1:playercount]+1
playerscore[(playercount+1):(2*playercount)]<-playerscore[1:playercount]+10
playercount<-2*playercount}
cardcount=0

library(shiny)
shinyServer(function(input, output) {
  output$dealer = renderUI({
    eval(parse(text=paste(dealercards,')',sep="")))
  })
  output$player = renderUI({
    eval(parse(text=paste(playercards,')',sep="")))
  })
  output$text <- renderText({
    paste("First Game!")
  })
  observeEvent(input$start, {
    shuffle<-sample(52)
    divstart<<-'div(style="display:inline-block",'
    playerfirstcard<<-paste('img(src = "Cards/',L[[shuffle[1]]],'",width=100,height=150),',sep="")
    playerlastcard<<-paste('img(src = "Cards/',L[[shuffle[2]]],'",width=100,height=150)',sep="")
    dealerfirstcard<<-paste('img(src = "Cards/',L[[shuffle[3]]],'",width=100,height=150),',sep="")
    dealerlastcard<<-paste('img(src = "Cards/',L[[shuffle[4]]],'",width=100,height=150)',sep="")
    poz<<-4
    playercards<<-paste(divstart,playerfirstcard,playerlastcard)
    dealercards<<-paste(divstart,dealerfirstcard,dealerlastcard)
    output$dealer = renderUI({
      eval(parse(text=paste(dealercards,')',sep="")))
    })
    output$player = renderUI({
      eval(parse(text=paste(playercards,')',sep="")))
    })
    dealerscore<<-c(0)
    playerscore<<-c(0)
    dealercount<<-1
    playercount<<-1
    if (scr[trunc((shuffle[3]-1)/4)+1] > 1) {dealerscore[1:dealercount]<<-dealerscore[1:dealercount]+scr[trunc((shuffle[3]-1)/4)+1]
    } else { dealerscore[1:dealercount]<<-dealerscore[1:dealercount]+1
    dealerscore[(dealercount+1):(2*dealercount)]<<-dealerscore[1:dealercount]+10
    dealercount<<-2*dealercount}
    if (scr[trunc((shuffle[4]-1)/4)+1] > 1) {dealerscore[1:dealercount]<<-dealerscore[1:dealercount]+scr[trunc((shuffle[4]-1)/4)+1]
    } else { dealerscore[1:dealercount]<<-dealerscore[1:dealercount]+1
    dealerscore[(dealercount+1):(2*dealercount)]<<-dealerscore[1:dealercount]+10
    dealercount<<-2*dealercount}
    if (scr[trunc((shuffle[1]-1)/4)+1] > 1) {playerscore[1:playercount]<<-playerscore[1:playercount]+scr[trunc((shuffle[1]-1)/4)+1]
    } else { playerscore[1:playercount]<<-playerscore[1:playercount]+1
    playerscore[(playercount+1):(2*playercount)]<<-playerscore[1:playercount]+10
    playercount<<-2*playercount}
    if (scr[trunc((shuffle[2]-1)/4)+1] > 1) {playerscore[1:playercount]<<-playerscore[1:playercount]+scr[trunc((shuffle[2]-1)/4)+1]
    } else { playerscore[1:playercount]<<-playerscore[1:playercount]+1
    playerscore[(playercount+1):(2*playercount)]<<-playerscore[1:playercount]+10
    playercount<<-2*playercount}
    shinyjs::enable("hit")
    shinyjs::enable("stand")
    output$text <- renderText({
      paste("New Game has started!")
    })
    cardcount<<-0
    })
  observeEvent(input$hit, {
    poz<<-poz+1
    playerlastcard<<-paste(',img(src = "Cards/',L[[shuffle[poz]]],'",width=100,height=150)',sep="")
    playercards<<-paste(playercards,playerlastcard)
    if (scr[trunc((shuffle[poz]-1)/4)+1] > 1) {playerscore[1:playercount]<<-playerscore[1:playercount]+scr[trunc((shuffle[poz]-1)/4)+1]
    } else { playerscore[1:playercount]<<-playerscore[1:playercount]+1
    playerscore[(playercount+1):(2*playercount)]<<-playerscore[1:playercount]+10
    playercount<<-2*playercount}
    output$player = renderUI({
      eval(parse(text=paste(playercards,')',sep="")))
    })
    if (min(playerscore) > 21) {
      output$text <- renderText({
        paste("Your score is:", min(playerscore), "You Lost!")
        })
      shinyjs::disable("hit")
      shinyjs::disable("stand")
    }
    })
  observeEvent(input$stand, {
    shinyjs::disable("hit")
    shinyjs::disable("stand")
    shinyjs::disable("start")
    while (TRUE) {
    if (min(dealerscore) > 21) {
      output$text <- renderText({
        paste("Dealer score is:", min(dealerscore), "You Win!")
        })
      shinyjs::enable("start")
      break
    } else if (max(dealerscore[dealerscore<22]) > max(playerscore[playerscore<22])) {
      output$text <- renderText({
        paste("Dealer score is:", max(dealerscore[dealerscore<22]), "wich is greater than yours","(", max(playerscore[playerscore<22]),")",".Dealer Wins!")
      })
      shinyjs::enable("start")
      break
    } else if ((max(dealerscore[dealerscore<22]) == max(playerscore[playerscore<22])) & (max(dealerscore[dealerscore<22]) > 16)) {
      output$text <- renderText({
        paste("Dealer score is:", min(dealerscore), "wich is equal to yours","(",min(playerscore),")",".Draw!")
      })
      shinyjs::enable("start")
      break
      } else {
        cardcount<<-cardcount+1
        shinyjs::html("text", paste("Dealer draws card",cardcount,"!"))
        Sys.sleep(1.5)
        poz<<-poz+1
        dealerlastcard<<-paste(',img(src = "Cards/',L[[shuffle[poz]]],'",width=100,height=150)',sep="")
        dealercards<<-paste(dealercards,dealerlastcard)
        if (scr[trunc((shuffle[poz]-1)/4)+1] > 1) {dealerscore[1:dealercount]<<-dealerscore[1:dealercount]+scr[trunc((shuffle[poz]-1)/4)+1]
        } else { dealerscore[1:dealercount]<<-dealerscore[1:dealercount]+1
        dealerscore[(dealercount+1):(2*dealercount)]<<-dealerscore[1:dealercount]+10
        dealercount<<-2*dealercount}
        output$dealer = renderUI({
        eval(parse(text=paste(dealercards,')',sep="")))
        })
      }
    }
  })
  })


