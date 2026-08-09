FROM rocker/shiny:latest

# 1. Dépendances système
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libgsl-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Installation des packages depuis le snapshot Posit (figé au 1er mars 2026)
RUN R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/2026-03-01')); \
    install.packages(c( \
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
    ))"

# 3. Copie des fichiers et configuration Shiny
COPY . /srv/shiny-server/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]