library(XML)
library(stringr)
library(wordcloud)
library(RColorBrewer)
library(data.table)
library(tm)
library(utils)

source("code/getListOfSongs.R")
source("code/getSongLyrics.R")
source("code/getWordList.R")
source("code/getLyricsFromList.R")
source("code/getWordCount.R")
###########################################################

id <- "queen"
###############################################################
## examples: queen, beatles, bee-gees, red-hot-chili-peppers ##
## rolling-stones, nirvana, bob-marley, michael-jackson      ##
###############################################################

listOfSongs <- getListOfSongs(id)
lyrics <- getLyricsFromList(listOfSongs,pause = 0.2)

## some lyrics may be unavailable due licensing restrictions
available <- lyrics != "\nWe are not in a position to display these lyrics due to licensing restrictions. Sorry for the inconvenience."
listOfSongs <- listOfSongs[available,]
lyrics <- lyrics[available]

wordCount <- getWordCount(lyrics,listOfSongs$popularity)

pal <- brewer.pal(8,'Dark2')
png(paste0("findings/Wordclouds/",id,".png"),width = 800,height = 800)
wordcloud(words = wordCount$word, freq = wordCount$freq,
          max.words = 150, random.order = F, colors = pal, 
          random.color = F,scale = c(13,1.1))
dev.off()
