#!/bin/bash

docker run -e PASSWORD=$PASSWORD --rm -it --name personal-finance -p 8787:8787 pdrsuite:happy-squirrel \
    -p 8787:8787 \
    -p 3838:3838 \
    -p 5249:5249 \
    -v ./:/home/rstudio/
