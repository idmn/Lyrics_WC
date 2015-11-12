getWordList <- function(text){
    t <- gsub("\n|\""," ",text)
    t <- gsub("\\.|!|,|\\?|;|-|:|\\(|\\)","",t)
    ## delete messages enclosed in []
    t <- gsub("\\[([A-Za-z]|\\d| )*\\]"," ",t)
    ## remove bad blanks
    t <- gsub("( )+"," ",t)
    t <- gsub("^ | $","",t)
    t <- str_to_lower(t)
    word_list <- str_split(t," ")[[1]]
    word_list
}