library(RMySQL)
library(sqldf)

# opens connection with a handle ucscDB
ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")

# send SQL query to server, disconnect from server when the information is retrieved
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);

# this shows all the databases on this server
result

# connect to specific database
hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")

# look at all the tables in the hg19 database
allTables <- dbListTables(hg19)

# observe that each different data type gets its own table
length(allTables)
allTables[1:5]

# get all the fields in one particular table in hg19 db
dbListFields(hg19, "affyU133Plus2")

# count all the records in the table
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

# get a dataFrame out of the table (Too much data for R)
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

# send a specific query, the results are stored in the DB
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")

# retrieve the results via fetch
affyMis <- fetch(query); quantile(affyMis$misMatches)

# automatically queries and retrieves the last 10 entries
# note: you mut clear the query afterwards
affyMisSmall <- fetch(query, n=10); dbClearResult(query);

dim(affyMisSmall)

dbDisconnect(hg19)



# useful for setting up mySQL:
# http://stackoverflow.com/questions/4785933/adding-rmysql-package-to-r-fails