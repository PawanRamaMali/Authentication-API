# Define plumber router

library(plumber)

api <- plumb("Server API/api.R")

api$run(swagger = TRUE)

