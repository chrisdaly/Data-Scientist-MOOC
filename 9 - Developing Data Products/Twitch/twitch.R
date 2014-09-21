library(httr)
library(jsonlite)
myapp = oauth_app("twitter", key = "youConsumerKeyHere", secret = "secret")
client_id = "7y7syvf1y5yvuv8iy93nes5cl175m2q"



GET("https://api.twitch.tv/kraken/?oauth_token=TOKEN")
a = GET('https://api.twitch.tv/kraken/streams/ukiyojp?client_id=7y7syvf1y5yvuv8iy93nes5cl175m2q')
