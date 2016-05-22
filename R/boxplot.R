boxplot <- function(tablename, attr, binwidth = 10, aggr = "AVG", jitter=FALSE,connid = 1){
if(!is.logical(jitter)) stop("jitter must be a logical - TRUE or FALSE")
query <- paste(sep="", "SELECT ",aggr,"(",attr,") AS value FROM (	SELECT FLOOR(",attr," / ",binwidth,") + 1 AS BinnedValue, ",attr," FROM ",tablename,") a GROUP BY BinnedValue")
start <- Sys.time()
boxdata <- db.q(query, nrows="max")
cat(paste("Query run time:",as.difftime(Sys.time() - start)))
plot <- ggplot(boxdata, aes(x = "Boxplot", y=value)) +
  geom_boxplot(outlier.color = "red")
if(jitter) {plot + geom_jitter()}
else {plot}
}