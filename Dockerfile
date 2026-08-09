FROM rocker/shiny:latest

# Dépendances système
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

# Dépôt CRAN figé à une date précise (ex: 1er mars 2026)
# Remplace la date si tu souhaites une autre date de référence
ENV CRAN_SNAPSHOT="https://packagemanager.posit.co/cran/2026-03-01"

# Installation de TOUS tes packages figés dans leur version exacte à cette date
RUN R -e "options(repos = c(CRAN = processx::renv %||% '$CRAN_SNAPSHOT')); install.packages(c( \
    'shiny', \
    'bslib', \
    'bsicons', \
    'thematic', \
    'svglite', \
    'tidyr', \
    'dplyr', \
    'ggplot2', \
    'bipartite', \
    'igraph', \
    'scales', \
    'ragg' \
), repos='$CRAN_SNAPSHOT')"

COPY . /srv/shiny-server/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]