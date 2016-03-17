# Multiple-Population
Machine Learning to identify multiple population in the data

This is a generic code that can be applied to any dataset (with some modification) to find multiple population while training linear models. This code has been written in R and uses the Auto dataset (from the ISLR package) for illustration. 

The model uses multiple starts and resampling methods to train multiple models (based on how the data is split), computes the R-squared value for each observation based on each of the models and reassigns observations to the splits based on the lowest R-squared from each of the models. This is an iterative process to generate the lowest R-squared for each number of multi-population.

#The Output
On execution, we see that the model optimizes this data at 4 splits. This indicates that there are possibly four hidden subsets in this population and it may be optimal to create 4 separate models for each subset. 

However, one should validate to see if the model is over-fitting. Cross-validation techniques can be applied to identify over-fitting and uncontrolled variance.   

