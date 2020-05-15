#Psych205 final project_Yuting Lin
library(car)
library(carData)
library(lattice)
library(ggplot2)

#####Look at the data######
#I chose a dataset from car package called "ChickWeight"
View(ChickWeight)
head(ChickWeight)
nrow(ChickWeight)
#####visualizing data######

ggplot(data = ChickWeight,aes(x = Time,y = weight, colour = Diet,shape = Diet)) +
  geom_point() +
  ggtitle("Chicken Weights repeated measure(presented groups)")+
  stat_smooth(aes(colour = Diet),size = 1,se = FALSE)
theme(legend.position = c(0.1,0.8))

boxplot(weight~Time,data = ChickWeight, xlab="Time", ylab="weight", main="Chicken Weights repeated measure")

plot(weight ~ Time, data=ChickWeight,xlab="Time",
     ylab="weight", main="Chicken Weights repeated measure")



#make the histograms for each type of diet
par(mfrow = c(2, 2))

for (diet.i in 1:4) {
  
  hist(x = ChickWeight$weight[ChickWeight$Diet == diet.i],
       xlab = "weights",
       xlim = c(0, 400),
       main = paste("Chick Weights\nDiet ", diet.i, sep = "")
  )
  
}

#####Model Fitting & classical Statistical Analysis#####
CW_mod1 <- lm(weight ~ Time, data = ChickWeight)
CW_mod2 <- lm(weight ~ Diet + Time, data = ChickWeight)
CW_mod3 <- lm(weight ~ Diet + Time + Diet*Time, data = ChickWeight)


(CW_mod1_sum <- summary(CW_mod1))
(CW_mod2_sum <- summary(CW_mod2))
(CW_mod3_sum <- summary(CW_mod3))


###Compare models###

anova(CW_mod1,CW_mod2,CW_mod3)


#CW_mod1 got 2 parameters;
#CW_mod2 got 5 parameters;
#CW_mod3 got 8 parameters
###Look at the difference of R2 adj between three models###
parameter_numbers <- c(2,5,8)
Radj_mod1 <- CW_mod1_sum$adj.r.squared
Radj_mod2 <- CW_mod2_sum$adj.r.squared
Radj_mod3 <- CW_mod3_sum$adj.r.squared
R2adj_combine <- c(Radj_mod1,Radj_mod2,Radj_mod3)
plot(parameter_numbers, R2adj_combine, type = "b", ylim = c(0.1,1.0))


#####Statistical Analysis by Resampling-Cross-validation#####

# set number of folds
k <- 10

# set seed for reproducibility
set.seed(73674)

# randomly create folds
folds <- sample(1:k,nrow(ChickWeight),replace=T)

# create vector for CV r squared results
CV_r2s <- rep(NA)

# run loop
for(i in 1:k){
  
  # get train and test sets
  train <- ChickWeight[folds!=i,]
  test <- ChickWeight[folds==i,]
  
  # fit complex model using train set as data
  new_model <- lm(weight ~ Diet + Time + Diet*Time, data = train)
  
  # fit 'null model', which is actually just mean of train set
  null_model <- mean(train$weight)
  
  # predict from complex model in test set 
  preds <- predict(new_model,test)
  
  # calculate SSE (sum of squared errors for complex model in test set)
  SSE <-  sum((preds - test$weight)^2)
  
  # calcuate SST (sum of squared errors for null model in test set)
  SST <- sum((preds - null_model)^2)
  
  # calculate CV r squared and add to vector
  CV_r2s[i] <- 1 - SSE/SST
  
}

# examine average CV r squared
mean(CV_r2s) 



