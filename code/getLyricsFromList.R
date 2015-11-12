## take pause after each song downloaded to avoid ban
## maybe it's not necessary
## pause is measured in seconds
getLyricsFromList <- function(listOfSongs, pause = 0.5){
    n <- nrow(listOfSongs)
    res <- rep("",n)
    ## progress bar
    pb <- txtProgressBar(min = 0, max = n, style = 3)
    for(i in 1:n){
        lyr <- getSongLyrics(listOfSongs[i,'url'])
        res[[i]] <- lyr
        Sys.sleep(pause)
        setTxtProgressBar(pb, i)
    }
    names(res) <- listOfSongs$title
    res
}
