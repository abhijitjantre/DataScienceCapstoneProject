library(shiny)
library(NLP)
library(tm)
library(data.table)

ngramtable <- fread("ngrams.txt")
setkeyv(ngramtable, c('word0', 'word1', 'word2', 'word3', 'freq'))

cleanthetext <- function(text){
        cleanedtext <- tolower(text)
        cleanedtext <- stripWhitespace(cleanedtext)
        cleanedtext <- gsub("[^\\p{L}\\s]+", "", cleanedtext, perl=T)
        return(cleanedtext)
}

splittheword <- function(text){
        cleanedtext <- cleanthetext(text)
        splittedtext <- unlist(strsplit(cleanedtext," "))
        return(splittedtext)
}

singlewordprediction <- function(cleanedtextlist){
        datatable <- ngramtable[list("-",cleanedtextlist[1])]
        datatable <- datatable[datatable$word2!="-",]
        datatable <- datatable[order(datatable$freq,decreasing = TRUE),]
        
        duplicate <- duplicated(subset(datatable,select = c("word1","word2")))
        datatable <- datatable[!duplicate,]
        
        alternateprediction = ''
        if (length(datatable) > 1){alternateprediction <- datatable$word2[2]}
        
        guessprediction <- datatable$word2[1]
        if(is.na(guessprediction)|is.null(guessprediction)){
                guessprediction <- "Unable to predict the next word"
        }
        return(c(guessprediction,alternateprediction))
}

twowordprediction <- function(cleanedtextlist){
        datatable <- ngramtable[list("-",cleanedtextlist[1],cleanedtextlist[2])]
        datatable <- datatable[datatable$word3!="-",]
        datatable <- datatable[order(datatable$freq,decreasing = TRUE),]
        
        duplicate <- duplicated(subset(datatable,select = c("word1","word2","word3")))
        datatable <- datatable[!duplicate,]
        
        alternateprediction = ''
        if (length(datatable) > 1){alternateprediction <- datatable$word3[2]}
        
        guessprediction <- datatable$word3[1]
        if(is.na(guessprediction)|is.null(guessprediction)){
                guessprediction <- singlewordprediction(cleanedtextlist[2])
        }
        return(c(guessprediction,alternateprediction))
}

threewordprediction <- function(cleanedtextlist){
        datatable <- ngramtable[list("-",cleanedtextlist[1],cleanedtextlist[2],
                                     cleanedtextlist[3])]
        datatable <- datatable[datatable$word4!="-",]
        datatable <- datatable[order(datatable$freq,decreasing = TRUE),]
        
        duplicate <- duplicated(subset(datatable,select = 
                                               c("word1","word2","word3","word4")))
        datatable <- datatable[!duplicate,]
        
        alternateprediction = ''
        if (length(datatable) > 1){alternateprediction <- datatable$word4[2]}
        
        guessprediction <- datatable$word4[1]
        if(is.na(guessprediction)|is.null(guessprediction)){
                shortlist <- c(cleanedtextlist[2],cleanedtextlist[3])
                guessprediction <- twowordprediction(shortlist)
                if(is.na(guessprediction)|is.null(guessprediction)){
                        guessprediction <-         
                                singlewordprediction(cleanedtextlist[3])
                }
        }
        return(c(guessprediction,alternateprediction))
}


shinyServer(function(input,output){
        
        output$cleaned <- renderText({
                rawinput <- input$rinput
                processedinput <- cleanthetext(rawinput)
                return(processedinput)
        })
        
        output$firstbestguess <- renderText({
                rawinput <- input$rinput
                processedinput <- cleanthetext(rawinput)
                firstbestguess <- "First Best Prediction Outcome"
                splitinput <- splittheword(rawinput)
                noofwords <- length(splitinput)
                
                if(noofwords==1){
                        firstbestguess <- singlewordprediction(splitinput)[1]
                }
                
                if(noofwords==2){
                        firstbestguess <- twowordprediction(splitinput)[1]
                }
                
                if(noofwords==3){
                        firstbestguess <- threewordprediction(splitinput)[1]
                }
                
                if(noofwords >3){
                        searchforwords <- c(splitinput[noofwords-2],
                                            splitinput[noofwords-1],
                                            splitinput[noofwords])
                        firstbestguess <- threewordprediction(searchforwords)[1]
                }
                return(firstbestguess)
        })
        
        output$secondbestguess <- renderText({
                rawinput <- input$rinput
                processedinput <- cleanthetext(rawinput)
                secondbestguess <- "Second Best Prediction Outcome"
                splitinput <- splittheword(rawinput)
                noofwords <- length(splitinput)
                
                if(noofwords==1){
                        secondbestguess <- singlewordprediction(splitinput)[2]
                }
                
                if(noofwords==2){
                        secondbestguess <- twowordprediction(splitinput)[2]
                }
                
                if(noofwords==3){
                        secondbestguess <- threewordprediction(splitinput)[2]
                }
                
                if(noofwords >3){
                        searchforwords <- c(splitinput[noofwords-2],
                                            splitinput[noofwords-1],
                                            splitinput[noofwords])
                        secondbestguess <- threewordprediction(searchforwords)[2]
                }
                return(secondbestguess)
        })
})