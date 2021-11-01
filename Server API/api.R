library(plumber)

users <- data.frame(
  id       = integer(),
  name     = character(),
  password = character(),
  stringsAsFactors = FALSE
)

# create test user
users <- rbind(
  users,
  data.frame(
    id       = 1,
    user     = "abc@example.com",
    password = bcrypt::hashpw("12345"),
    stringsAsFactors = FALSE
  )
)
users <- rbind(
  users,
  data.frame(
    id       = 2,
    user     = "efg@example.com",
    password = bcrypt::hashpw("45678"),
    stringsAsFactors = FALSE
  )
)


#* @apiTitle API Authentication

#* Log requests
#* @filter logger
function(req){
  print(paste(" REQUEST IS", typeof(req)))
  cat(as.character(Sys.time()), "-", 
      req$REQUEST_METHOD, req$PATH_INFO, "-", 
      req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n")
  forward()
}

#* Route / to /__swagger__
#* filter route-to-swagger
function(req) {
  if (req$PATH_INFO == "/") {
   # print(paste(" req$PATH_INFO <- /__swagger__"))
    req$PATH_INFO <- "/__swagger__/"
  }
  
  forward()
}

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = "") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @png
#* @get /plot
function() {
  rand <- rnorm(100)
  hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
  print(paste("The output is  ",a,b))
  as.numeric(a) + as.numeric(b)
  
  
}
