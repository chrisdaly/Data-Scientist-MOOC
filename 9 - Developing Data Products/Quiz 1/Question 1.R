library(manipulate)
myPlot <- function(s) {
  plot(cars$dist - mean(cars$dist), cars$speed - mean(cars$speed))
  abline(0, s)
}


manipulate(myPlot(s), x.s = slider(0, 2, step = 0.1))
manipulate(myPlot, s = slider(0, 2, step = 0.1))
manipulate(myPlot(s), slider = x(0, 2, step = 0.1))
manipulate(myPlot(s), s = slider(0, 2, step = 0.1))