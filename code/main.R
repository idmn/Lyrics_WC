library(XML)
library(stringr)
library(wordcloud)
library(RColorBrewer)
library(data.table)
library(tm)

setwd("D:/Iaroslav/Projects/What Do They Sing About/code2")
source("getListOfSongs.R")
source("getSongLyrics.R")
source("getWordList.R")
source("getLyricsFromList.R")
source("getWordCount.R")
###########################################################

id <- "queen"
###############################################################
## examples: queen, beatles, bee-gees, red-hot-chili-peppers ##
## helloween                                                 ##
###############################################################

listOfSongs <- getListOfSongs(id)
lyrics <- getLyricsFromList(listOfSongs,pause = 0.2)

## some lyrics may be unavailable due licensing restrictions
available <- lyrics != "\nWe are not in a position to display these lyrics due to licensing restrictions. Sorry for the inconvenience."
listOfSongs <- listOfSongs[available,]
lyrics <- lyrics[available]

wordCount <- getWordCount(lyrics,listOfSongs$popularity)

pal <- brewer.pal(8,'Dark2')
wordcloud(words = wordCount$word, freq = wordCount$freq,
          max.words = 150, random.order = F, colors = pal, 
          random.color = F)

