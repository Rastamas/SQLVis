connect <- function(host = "localhost", user="gpadmin", dbname = "gpadmin", password = "password", port = 5432)
{
db.connect(host = host, user = user, dbname = dbname, password = password, port = port)
cat("Don't forget to db.disconnect() when you are done!")
}