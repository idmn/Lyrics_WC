processTableRow <- function(node){
    title <- xpathSApply(node,"td/a",xmlValue)
    title <- gsub("\n| Lyrics\n","",title)
    url <- xpathSApply(node,"td/a/@href")
    popularity <- toString.XMLNode(xpathSApply(node,"td/span")[[1]])
    popularity <- gsub(".+width:|%;.+","",popularity)
    popularity <- as.numeric(popularity)
    res <- data.frame(title,url,popularity,stringsAsFactors = F)
    row.names(res) <- NULL
    res
}

getSongsFromOnePage <- function(artist_id, pagenum, getLastPageNum = F){
    url <- paste0("http://www.metrolyrics.com/",
                  artist_id,"-alpage-",pagenum,".html")
    ## here an 'incomplete final line' warning may appear,
    ## so I suppress warnings here
    parsed <- htmlParse(suppressWarnings(readLines(url)))
    table <- xpathSApply(parsed,"(//table[@class='songs-table compact'])[1]")[[1]]
    songs <- xpathSApply(table,"tbody/tr")
    res <- lapply(songs,processTableRow)
    do.call(rbind,res) -> res
    
    if(getLastPageNum){
        last_page_num <- xpathSApply(parsed,
                                     "//p[@class = 'pagination']/span/a",
                                     xmlValue)
        last_page_num <- tail(last_page_num,1)
        last_page_num <- gsub("\n|\t","",last_page_num)
        last_page_num <- suppressWarnings(as.numeric(last_page_num))
        res <- list(res,last_page_num)
    }
    res
}

getListOfSongs <- function(artist_id){
    last_page_num <- NA
    i <- 1
    res <- NULL
    
    while(ifelse(is.na(last_page_num),T,i <= last_page_num)){
        tmp <- getSongsFromOnePage(artist_id,i,T)
        res <- rbind(res,tmp[[1]])
        last_page_num <- tmp[[2]]
        rm(tmp)
        i <- i + 1
    }
    res
}
