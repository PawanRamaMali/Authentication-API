library(httr)

login <- list(
  user="abc@example.com",
  password="1234"
)


res <- POST("http://127.0.0.1:9090/authentication", body = login, encode = "json", verbose())

team <- GET("http://127.0.0.1:9090/secret", verbose())


res$content

res$code

content(res$message)
