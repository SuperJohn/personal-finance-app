FROM rocker/shinyverse:latest

WORKDIR ..
COPY . /home/rstudio

RUN R -e 'install.packages("shiny", "renv")'
COPY . /.
EXPOSE 8787 3838 5249
ENV PASSWORD = $PASSWORD
CMD R -e 'renv::restore()'
CMD R -e 'shiny::runApp("global.R", port = 3838, host = "0.0.0.0")'

COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY /app /srv/shiny-server/

# Allow permissions
RUN chown -R shiny:shiny /srv/shiny-server

# CMD ["/usr/bin/shiny-server.sh"]
