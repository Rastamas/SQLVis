heatmap <- function(tablename, grouper1, binwidth1, grouper2, binwidth2, attr, aggr, connid = 1){
  query <- paste(sep = "", "SELECT BinnedValue1 * ", binwidth1, " AS xvalue, ", aggr, "(nullif(",grouper2,", 'NA')::int) as yvalue, FLOOR(", aggr, "(nullif(",attr,",'NA')::int)) AS zvalue FROM(SELECT FLOOR(", grouper1, " / ", binwidth1, ") + 1 AS BinnedValue1, FLOOR(nullif(", grouper2, ", 'NA')::int / ", binwidth2, ") +1 AS BinnedValue2, ", grouper1, ", ", grouper2, ", ", attr, " FROM ", tablename, ") a GROUP BY BinnedValue1, BinnedValue2")
  start <- Sys.time()
  heatmapdata <- db.q(query, nrows="max")
  cat(paste("Query run time:",as.difftime(Sys.time() - start))) 
  
  ggplot(heatmapdata, aes(x=xvalue, y=yvalue)) + 
    geom_tile(show.legend = FALSE, aes(fill=heatmapdata$zvalue)) + scale_fill_gradient2(
      low = "#0000FF", 
      mid = "#00FF00", 
      high = "#FF0000", 
      midpoint = max(heatdata$zvalue, na.rm=TRUE) / 2)
}