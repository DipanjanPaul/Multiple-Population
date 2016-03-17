# Multiple-Population
Machine Learning to identify multiple population in the data

This is a generic code that can be applied to any dataset (with some modification) to find multiple population while training linear models. This code has been written in R and uses the Auto dataset (from the ISLR package) for illustration. 

The model uses multiple starts and resampling methods to train multiple models (based on how the data is split), computes the R-squared value for each observation based on each of the models and reassigns observations to the splits based on the lowest R-squared from each of the models. This is an iterative process to generate the lowest R-squared for each number of multi-population.

#The Output
Testing for 1 splits for 50 starts and tolerance at 0.001 - Best R-squared: 0.82
Testing for 2 splits for 50 starts and tolerance at 0.001 - Best R-squared: 0.93
Testing for 3 splits for 50 starts and tolerance at 0.001 - Best R-squared: 0.967
Testing for 4 splits for 50 starts and tolerance at 0.001 - Best R-squared: 0.980
Testing for 5 splits for 50 starts and tolerance at 0.001 - Best R-squared: 0.985
Testing for 6 splits for 50 starts and tolerance at 0.001 - Best R-squared: 0.989
Testing for 7 splits for 50 starts and tolerance at 0.001 - Best R-squared: 0.992
Testing for 8 splits for 50 starts and tolerance at 0.001 - Best R-squared: 0.994
Testing for 9 splits for 50 starts and tolerance at 0.001 - Best R-squared: 0.994
Testing for 10 splits for 50 starts and tolerance at 0.001 - Best R-squared: 0.995 

It can be seen that the model is most likely optimizing at around 4 splits. This means that there are possibly four hidden subsets in this population and it may be optimal to create 4 separate models for each subset. 

However, one should validate to see if the model is over-fitting. Cross-validation techniques can be applied to identify over-fitting and uncontrolled variance.   

