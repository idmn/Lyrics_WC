getSongLyrics <- function(url){
    parsed <- htmlParse(readLines(url))
    lyrics <- xpathSApply(parsed, "//div[@id = 'lyrics-body-text']",xmlValue)
    lyrics <- tidyLyrics(lyrics)
}

tidyLyrics <- function(lyrics){
    ## aB => a\nB
    lyrics <- gsub("([a-z])([A-Z])",'\\1\n\\2',lyrics)
    lyrics <- gsub('\t','',lyrics)
    lyrics
}
