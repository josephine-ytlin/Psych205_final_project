# PSYCH205 Data analysis 
## Introduction
I chose “ChickWeight” from package “dataset” in R. It’s about measuring chicken weights many times(each second day) tried to explore the different effectiveness between four feeding types of supplements.
“weight” is a numeric vector giving the body weight of the chick (gm); “Time” is a numeric vector giving the number of days since birth when the measurement was made; “Chick” is an ordered factor with levels giving a unique identifier for the chick. “Diet” is a factor with levels 1, ..., 4 indicating which experimental diet the chick received.
## Methods.
The body weights of the chicks were measured at birth and every second day until day 20. They were also measured on day 21. There were four groups on chicks on different protein diets.
## Data Display
I made the scatterplot, boxpot and histogram to show the pattern of the data and tried to present four different weight growing pattern depends on different type of diet.
## Model Description and Model Fitting.
(Model 1)simple linear regression: weight =β0 +β1Time +ε
(Model2)Add one covariate variable: weight = β0 + β1Time + β2Diet + ε
(Model3)Add the interaction:
weight = β0 + β1Time + β2Diet + β3Time * Diet + ε

There is a significant positive relation showed in CW_mod1_sum, the weight will go higher with the day passed by. CW_mod2_sum presented that each type of the diet cause significant effect on chicken's weight. We can see the significant interaction effect between Diet and Time in CW_mod3_sum, which means different diet may have a different weight-growing rate.
Model CW_mod2 fits significantly better than model CW_mod1, and Model CW_mod3 fits significantly better than model CW_mod2. So we could say it would be the best to take to covariate variable and the interaction into account in the model.

## Classical Statistical Analysis

We can see these three R2adj change slightly(they all around .07), but still, with the more parameters the higher R2adj we got, which means the more complex model can explain the data better.
## Statistical Analysis by Resampling.
By performing 10 fold cross-validation, here we get the average cross-validation R2cv =
0.701,this shows my model doesn't get overfitting and make a great prediction of the data.
## Conclusion
If I got time in the future, I would try to fit the mixed effect model to take the random effect into account for this dataset.
