FROM rocker/tidyverse:latest
WORKDIR ..
COPY . /home/rstudio

## Install rstan (downloads and builds all dependencies)
## Make R the default
# CMD [”R”]

ENV PASSWORD='Sandy319'
PORT 8787:8787
PORT 3838:3838
PORT 5249:5249

RUN docker run --rm -it --name personal-finance -p 8787:8787 rocker/tidyverse:latest \
    -p 8787:8787 \
    -p 3838:3838 \
    -p 5249:5249 \
    -v ./:/home/rstudio/