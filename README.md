# Lyrics_WC
Creating wordclouds for lyrics.

With help of the scripts one can easily download all the lyrics of the specified artist and build a wordcloud for them. `metrolyrics.com` site is used as a source of songs lyrics. 

In brief, open main.R, make sure that the project directory is set as the working directory. Go to the line `id <- "queen"` and write the id of an artist you are interested in instead of `"queen"`, or leave it as it is. Then run the code and wait. It make take a few minutes, because here I make a pause each time a page with lyrics is downloaded to avoid IP ban. But you make turn this off by setting the corresponding parameter to zero.

How to know artist's id? For example, Queen's homepage at metrolyrics is `metrolyrics.com/queen-overview.html`. Id is the part of the url after `metrolyrics.com/` and before `-overview.html`.

Now about the functions that are called in main.R. I tried to make their names descriptive, but in any case here are some words about them:

* `getListOfSongs`. The single argument is the artist's id. This function gets the catalog of songs as a data.frame with three columns. First column contains song titles, second - url of the corresponding page with lyrics and third - lyrics popularity as it counted by metrolyrics.  
* `getLyricsFromList`. The first argument is the list of songs such as created by the previous function. The second argument - pause that will be made after each song's lyrics downloaded, measured in seconds. I do it to avoid IP ban. Maybe it's not so neccessary, because the process of extracting lyrics from a page takes a while, so you may try setting this parameter to zero. The function outputs a vector, each element of which is a lyrics of a song.
* `getWordCount`. The first argument is the list of lyrics, the second - list of their popularities. By default, this argument is set to 100 (percents), so that all the lyrics are equally popular. The output of the function is a data.table with words in the first column and their "frequencies" in the second. I'll explain how they are calculated by an example. Suppose an artist has two songs: Song1 and Song2. Word "yeah" occurs 10 times in the Song1 and 4 times in the Song2. Song1 popularity is 30 and Song2 popularity is 100. Then the resulting "frequency" for word "yeah" is `10*30/100 + 4*100/100 = 7`. Such a way of counting was selected to make more popular songs have more influence on the result.

At the end `wordcloud` from the same named package by Ian Fellows is used. To read more about it you may want to look at it's [documentation](https://cran.r-project.org/web/packages/wordcloud/wordcloud.pdf).
