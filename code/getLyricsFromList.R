## take pause after each song downloaded to avoid ban
## maybe it's not necessary
## pause is measured in seconds
getLyricsFromList <- function(listOfSongs, pause = 0.5){
    res <- NULL
    for(i in 1:nrow(listOfSongs)){
        lyr <- getSongLyrics(listOfSongs[i,'url'])
        res <- c(res, lyr)
        Sys.sleep(pause)
    }
    names(res) <- listOfSongs$title
    res
}
