# Define plumber router

library(plumber)

api <- plumb("api.R")

api$run(swagger = TRUE)

