getWordCount <- function(listOfLyrics, popularity = 100){
    wordsBySongs <- sapply(listOfLyrics,getWordList)
    ## count with respect of songs popularity
    wordCount <- lapply(wordsBySongs, table)
    wordCount <- mapply(function(x,y) x*y/100,wordCount,popularity)
    wordCount <- lapply(wordCount,as.data.table)
    wordCount <- do.call(rbind, wordCount)
    wordCount <- wordCount[,.(freq = sum(N)),by = V1]
    setnames(wordCount,"V1","word")
    ## remove stopwords
    wordCount <- wordCount[!(wordCount$word %in% SW),,]
    ## sort by freq
    wordCount <- wordCount[order(-freq)]
    ## round freqs
    wordCount$freq <- round(wordCount$freq,3)
    wordCount
}

## stop words
SW <- stopwords("en")
SW <- c(SW,'will')