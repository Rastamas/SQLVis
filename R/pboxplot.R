parallel_boxplot <- function(tablename, attr, grouper, binwidth = 10, aggr = "AVG", connid = 1){
  query <- paste(sep="", "SELECT ",grouper," as grouper, ",aggr,"(",attr,") AS value FROM (SELECT FLOOR(",attr," / ",binwidth,") + 1 AS BinnedValue, ",attr,", ",grouper," FROM ",tablename,") a GROUP BY BinnedValue, ", grouper)
  start <- Sys.time()
  pboxdata <- db.q(query, nrows="max")
  cat(paste("Query run time:",as.difftime(Sys.time() - start)))
  ggplot(pboxdata, aes(factor(grouper), value)) + 
    geom_boxplot()
}