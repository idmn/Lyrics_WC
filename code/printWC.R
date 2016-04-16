## code to print wordcloud by wordlist and specified title

printWC <- function(wordCount, file, title = NULL){
    ## make picture
    pal <- c("#5a5255", "#559e83", "#ae5a41", "#c3cb71", "#1b85b8")
    png(file, width = 800, height = 800)
    par(bg = "black")
    wordcloud(words = wordCount$word, freq = wordCount$freq,
              max.words = 150, random.order = F, colors = pal, 
              random.color = F,scale = c(9,0.9))
    dev.off()
    
    if(!is.null(title) && is.character(title) && length(title) == 1){
        ## make title
        png("findings/tmp/__title.png",width = 800, height = 70)
        par(bg = 'black', ps = 55)
        op <- par(mar = rep(0, 4))
        plot.new()
        par(op)
        text(0.5,0.5,title,col = "white")
        dev.off()
        
        ## bind together
        title <- readPNG("findings/tmp/__title.png")
        pic <- readPNG(file)
        res <- abind(title, pic, along = 1)
        writePNG(res, file)
        file.remove("findings/tmp/__title.png")
    }
}