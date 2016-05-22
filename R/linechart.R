linechart <- function(tablename, attr, binwidth = 10, aggr = "AVG",connid = 1){
  
  query <- paste(sep = "", "SELECT BinnedValue * ", binwidth, " as value, CASE WHEN ", aggr, "(",attr,") IS NOT NULL THEN ",aggr,"(",attr,") ELSE '0' END AS aggr FROM (SELECT FLOOR(",attr," / ",binwidth,") + 1 AS BinnedValue,",attr," FROM ",tablename,") a GROUP BY BinnedValue ORDER BY BinnedValue")
  start <- Sys.time()
  cdata <- db.q(conn.id = connid, query, nrows = "max")
  cat(paste("Query run time:",as.difftime(Sys.time() - start)))
  ggplot(data=cdata, aes(x = value, y = aggr)) + 
    geom_line() + 
    geom_smooth(se = FALSE)
}

