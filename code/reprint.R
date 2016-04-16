## to reprint wordclouds by collected wordlists
WList <- paste0("findings/WordLists/",list.files("findings/WordLists/"))

for(i in WList){
    id <- gsub("(findings/WordLists/)|(.csv)","",i)
    wordCount <- read.csv(i)
    title <- paste0('http://www.metrolyrics.com/', id, '-overview.html') %>%
        readLines() %>%
        htmlParse() %>%
        xpathSApply('//h1', xmlValue)
    file <- paste0("findings/Wordclouds/",id,".png")
    printWC(wordCount, file, title)
}
