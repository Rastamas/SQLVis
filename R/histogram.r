histogram <- function(tablename, grouper, connid = 1){
query <- paste("SELECT COUNT(*) as count, ", grouper, "as groups  FROM ", tablename, " GROUP BY ", grouper, " ORDER BY ", grouper)
start <- Sys.time()
bardata <- db.q(conn.id = connid, query)
cat(paste("Query run time:",as.difftime(Sys.time() - start)))
ggplot(data = bardata, aes(groups, count)) + geom_bar(stat="identity") + scale_x_discrete(limits = bardata$groups)
}