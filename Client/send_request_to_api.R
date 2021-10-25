library(httr)
library(jsonlite)
options(stringsAsFactors = FALSE)
# url for local testing
url <- "http://127.0.0.1:8000"
# url for docker container
url <- "http://0.0.0.0:8000"
# read example stock data
.data <- read.csv('./path/to/data/stocks.csv')
# create example body
body <- list(
  .data = .data,
  .trans = "w",
  .key = "stock",
  .value = "price",
  .select = c("X","Y","Z")
)
# set API path
path <- 'api'
# send POST Request to API
raw.result <- POST(url = url, path = path, body = body, encode = 'json')
# check status code
raw.result$status_code
# retrieve transformed example stock data
.t_data <- fromJSON(rawToChar(raw.result$content))
