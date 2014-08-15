target_url <- "http://your.address.goes.here"
target_localfile = "localFile.suffix"
if (!file.exists(target_localfile)) {
  download.file(target_url, target_localfile) #may need modifying if binary etc
  library(tools)       # for md5 checksum
  sink("download_metadata.txt")
  print("Download date:")
  print(Sys.time() )
  print("Download URL:")
  print(target_url)
  print("Downloaded file Information")
  print(file.info(target_localfile))
  print("Downloaded file md5 Checksum")
  print(md5sum(target_localfile))
  sink()
}
}