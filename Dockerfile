FROM rocker/shiny:latest

# 1. Installation des dépendances système Linux essentielles
RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff5-dev \
    libgsl-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Fixation du dépôt CRAN au snapshot Posit
RUN R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/2026-03-01'))"

# 3. Installation des packages principaux de l'interface et manipulation de données
RUN R -e "install.packages(c('shiny', 'bslib', 'bsicons', 'thematic', 'svglite', 'tidyr', 'dplyr', 'ggplot2', 'scales', 'ragg'), repos='https://packagemanager.posit.co/cran/2026-03-01')"

# 4. Installation des packages de réseaux/graphes (bipartite et igraph)
RUN R -e "install.packages(c('igraph', 'bipartite'), repos='https://packagemanager.posit.co/cran/2026-03-01')"

# 5. Copie des fichiers de ton application dans Shiny Server
COPY . /srv/shiny-server/

# 6. Configuration du port
EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]