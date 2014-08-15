library(lattice)
library(datasets)

airquality <- transform(airquality, Month = factor(Month))
# p <- xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))
p <- xyplot(Ozone ~ Wind | Month, data = airquality, panel = function(x, y, ...){
  panel.xyplot(x, y, ...)
  panel.lmline(x, y, col = 2)
})

print(p)