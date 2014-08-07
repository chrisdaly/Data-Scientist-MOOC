# establish connection with url
con = url("http://biostat.jhsph.edu/~jleek/contact.html")

# read the html into R
htmlCode = readLines(con)

# close the connection
close(con)

# Question: How many characters in the 10, 20, 30 and 100th lines
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])