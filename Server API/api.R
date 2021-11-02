library(plumber)
library(mongolite)

mongoUrl <- "mongodb://localhost:27017/admin" 
#<-admin here is the mongodb database that stores the authentication info

# specify your collection
colname <- "user"

# specify your database
dbname <- "mongoengine"

# create connection (con)
con <- mongo(collection = colname, url = mongoUrl, db=dbname)

# count how many records (fyi this is just a test)
#con$count('{}')


#* @apiTitle API Authentication

#* Log requests
#* @filter logger
function(req){
  #print(paste(" REQUEST IS", typeof(req)))
  cat(as.character(Sys.time()), "-", 
      req$REQUEST_METHOD, req$PATH_INFO, "-", 
      req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n")
  forward()
}


#* Authenticate Qualisense Login
#* @serializer json
#* @post /login
function(req, res) {
  
  if (is.null(req$body$user) | is.null(req$body$password))
  {
    return(list(
      status = "Login Failed",
      code = 404,
      message = "Inavalid parameters"
    ))
  }
  
  user_name <- req$body$user
  hashed_password <-req$body$password
  print(paste0("Username is ",user_name))

  
  
  user_password <- con$find(
    query = paste0('{"username" : "', user_name, '"}'),
    fields = '{"password" : true, "_id" : false }',
    limit = 1
  )
 
  if (is.null(user_password)){
    print(paste0("Username  ",user_name," not found in database "))
    return(list(
      status = "Login Failed",
      code = 404,
      message = "Login Data Not Found"
    ))
    
  }
  
  
  print(paste0("Password is ",user_password))
  print(paste0("Hashed Password is ",hashed_password))
  
  if ( hashed_password == user_password)
  {
    
    
    return(list(
      status = "Authentication Successfull",
      code = 200,
      message = "Login Success"
    ))
  }
  else
  {
    return(list(
      status = "Login Failed",
      code = 404,
      message = "Incorrect Password"
    ))
  }
  

  return(list(
    status = "Login Failed",
    code = 404,
    message = "NOA"
  ))

}
