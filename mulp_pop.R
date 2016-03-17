multipopl <- function(file, pop_n, tolerance, start_count, seed) {
  parm <- "eda"
  if (parm == "debug") {
    library(ISLR)
    file <- Auto
    pop_n <- 2
    tolerance <- 0.001
    start_count <- 50
    seed <- 12345
  }
  
  print(paste("Testing for ", pop_n, " splits for ", start_count, " starts and tolerance at ", tolerance), sep="", Quote=F)
  
  rows <- nrow(file)
  set.seed(seed)
  spl <- sample(x=1:pop_n, size=rows, replace=T)
  file$spl <- spl
  
  rsq_monitor <- data.frame()
  df <- data.frame()
  
  for (k in 1:start_count) {
#    print(c("Start Count: ", k))
    
    rsq_monitor[k, c('iteration')] <- k
    
    if (k > 1) {
      spl <- sample(x=1:pop_n, size=rows, replace=T)
      file$spl <- spl
    }
    
    file$yhat <- NA
    rsq_prev <- 0
    min_rsq_reached <- "N"
    i <- 1
    
    while (min_rsq_reached == "N") {
      file <- file[order(file$spl),]
      file$yhat <- unlist(lapply(1:pop_n, function(x) predict(lm(mpg ~ cylinders + displacement + horsepower + 
                                                                   weight + acceleration + year + origin, data=file[file$spl==x,]), 
                                                              newdata=file[file$spl==x,])))
      
      rsq <- 1 - sum((file$mpg - file$yhat)**2)/sum((file$mpg - mean(file$mpg))**2)
      
      if (i == 1) {
#        print(c('Startig R Square: ', rsq))
        rsq_monitor[k, c('rsq')] <- rsq
      }
      
      if (((rsq - rsq_prev) < tolerance) | (i > 50))  {
        min_rsq_reached == "Y"
#        print(c('Ending R Square: ', rsq))
        if (rsq > rsq_monitor[k, c('rsq')]) {
          rsq_monitor[k, c('rsq')] <- rsq
        }
        break
      }
      
      rsq_prev <- rsq
      
      x <- do.call('cbind', (lapply(1:pop_n, function(x) (file$mpg - (predict(lm(mpg ~ cylinders + displacement + horsepower + 
                                                                                   weight + acceleration + year + origin, data=file[file$spl==x,]), 
                                                                              newdata=file)))**2)))
      
      file$spl <- apply(x, 1, function(x) which(x == min(x)))
      
      i <- i + 1
    }
    
    df[1:nrow(file),k] <- file$spl
    
  }

  print(c('Best R Square: ', max(rsq_monitor$rsq)))
  file$spl <- (df[,which(rsq_monitor$rsq == max(rsq_monitor$rsq))])
  return(file)
}

library(ISLR)
parm <- "none"

if (parm == "eda") {
  head(Auto)
  summary(Auto)
}

out <- list(10)
for (j in 1:10) {
#  print(c('Nr. of splits: ', j))
  out[[j]] <- multipopl(Auto, j, 0.001, 50, 12345)
}


