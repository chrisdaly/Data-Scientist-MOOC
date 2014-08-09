## Example 1 Facetted Scatterplot
# names(iris) = gsub("\\.", "", names(iris))
# rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')

## Example 2 Facetted Barplot
hair_eye = as.data.frame(HairEyeColor)
rPlot(Freq ~ Hair | Eye, color = 'Eye', data = hair_eye, type = 'bar')

## Example 1 Facetted Scatterplot
# names(iris) = gsub("\\.", "", names(iris))
# r1 <- rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')
# r1$save('r1.html', cdn = TRUE)
# cat('<frame src="r1.html" width=100%, height = 600></iframe>')
# 
# r1$print(r1)