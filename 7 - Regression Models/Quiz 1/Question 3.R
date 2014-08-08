data(mtcars)

y <- mtcars$mpg
x <- mtcars$wt


lm(y ~ x)