library(lattice)
library(ggplot2)
library(datasets)

state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

data(mpg)
qplot(displ, hwy, data = mpg)