FROM trestletech/plumber
# Install dependencies
RUN apt-get update --allow-releaseinfo-change && apt-get install -y \
    liblapack-dev \
    libpq-dev
# Install R packages
RUN R -e "install.packages(c('tidyr', 'dplyr', 'magrittr', 'httr', 'jsonlite'), \
repos = 'http://cran.us.r-project.org')"
# Add API
COPY ./api /api
# Make port available
EXPOSE 8000
# Entrypoint
ENTRYPOINT ["R", "-e", \
"api <- plumber::plumb('api.R'); \
api$run(host = '0.0.0.0', port= 8000)"]
CMD ["/api.R"]
