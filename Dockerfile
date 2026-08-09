FROM rocker/shiny:latest

# Dépendances système nécessaires pour igraph, svglite, etc.
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

# Installation de tous tes packages R
RUN R -e "install.packages(c( \
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
), repos='https://cloud.r-project.org/')"

# Copie des fichiers du projet dans le serveur
COPY . /srv/shiny-server/

# Port d'écoute pour Render
EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]