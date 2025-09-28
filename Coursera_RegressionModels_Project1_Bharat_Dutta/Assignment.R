#QUESTIONS
#Is an automatic or manual transmission better for MPG?
#Quantify the MPG difference between automatic and manual transmissions.

#LOADING DATA
data(mtcars)
View(mtcars)
str(mtcars)

#REQUIRED PACKAGES
library(ggplot2)

#PREPROCESSING
?mtcars
correl <- cor(mtcars$mpg, mtcars[,-1])
###some variables are actually factors, not num
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$vs <- as.factor(mtcars$vs); levels(mtcars$vs) <- c("V-shaped", "Straight")
mtcars$am <- as.factor(mtcars$am); levels(mtcars$am) <- c("Auto", "Manual")
mtcars$gear <- as.factor(mtcars$gear)
mtcars$carb <- as.factor(mtcars$carb)

#EXPLORATORY ANALYSIS
pairs(mpg ~ ., data = mtcars) #mpg has distinct relations with cyl, disp, hp, wt, vs, am (increasing or decreasing)
plot(mtcars$am, mtcars$mpg)
summary(mtcars)

#STAISTICAL ANALYSIS
##Modelling
set.seed(1234)
model1 <- lm(mpg ~ ., data = mtcars)
model2 <- lm(mpg ~ cyl + disp + hp + wt + vs + am, data = mtcars)
best.model <- step(model1, direction = "backward")
summary(best.model)

##Quantifying
plot(mtcars$am, mtcars$mpg, main = "MPG vs. Transmission Type", ylab = "MPG")
t.test(mpg ~ am, data = mtcars)

#APPENDIX
#Exploratory Plots
pairs(mpg ~ ., data = mtcars, main = "MPG vs. Performance Parameters")                                                       #all relationships                                              

ggplot(mtcars, aes(cyl, mpg)) + geom_bar(stat = "Identity") + 
  xlab("Number of Cylinders") + ylab("MPG") + ggtitle("MPG vs. No. of Cylinders") +
  theme(plot.title = element_text(hjust = 0.5))                                      #MPG vs. CYL

ggplot(mtcars, aes(am, mpg)) + geom_count(aes(color = ..n..)) + guides(color = 'legend') +
  ylab("MPG") + ggtitle("MPG vs. Transmission Type") + xlab("Transmission") +
  theme(plot.title = element_text(hjust = 0.5))                                      #MPG vs. AM, count plot 

plot(mtcars$am, mtcars$mpg, main = "MPG vs. Transmission Type", ylab = "MPG")

##Resiudals and Diagnostics
par(mfrow = c(2,2)); plot(best.model)                                                #Residual Plots

hatvalues <- round(hatvalues(best.model),3)                                          #Diagnostic Checks
dfbetas <- round(dfbetas(best.model),3)
