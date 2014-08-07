library(httr)

library(jsonlite)
library(rjson)
library(XML)

# find OAuth settings for github
github <- oauth_endpoints("github")

# values from registering an application (callback URL = http://localhost:1410/)
client_id = 'dd4312411e8cdbebc532'
client_secret = 'f5b8ca4613420910fd9c9aa6f3f126d6ba12ee44'

# start the authorization process
my_app <- oauth_app("github", key=client_id, secret=client_secret)

# sign in and get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), my_app)
gtoken <- config(token = github_token)

# URL to query
desired_url = "https://api.github.com/users/jtleek/repos"

# request the webpage from the URL
req <- GET(desired_url, gtoken)

# extract out the content from the request
json1 = content(req)

# convert the list to json
json2 = jsonlite::fromJSON(toJSON(json1))

# check the names within the object
names(json2)

# "full_name" is the the relevant field
a <- json2$full_name


# how to filter by "full_name" and then get the value of "created_at"